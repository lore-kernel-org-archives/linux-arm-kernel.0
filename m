From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jun 2013 18:10:18 +0100
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130603171017.GN18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 06:45:37PM +0200, Thomas Petazzoni wrote:
> From: Willy Tarreau <w@1wt.eu>
> 
> Marvell uses a specific atag in its u-boot which includes among other
> information the MAC addresses for up to 4 network interfaces. This
> atag is parsed, and if found the MAC addresses are extracted there and
> assigned to node aliases eth0..3 with the name "mac-address".
> 
> This allows, with the non-DT capable bootloaders currently used on
> most Marvell platforms, to get a proper MAC address for the different
> interfaces.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

You know, my reaction to this is to nack it because:

(a) Marvell didn't talk to me about adding a new tag.
(b) There is an established precident that we do not pass MAC addresses
    to the kernel in this way (such attempts have been rejected in the
    past.)
(c) It goes completely against the design spirit of ATAGs by combining
    many different types and instances of information into one tag.
(d) It picks a tag ID without understanding how tag IDs are allocated.
    (the idea is 0x41NNNNVV where NNNN = machine ID for machine specific
    tags.)

Everyone who has gone around extending ATAG stuff has made exactly the
same mistakes time and time again - mostly stemming from the fact that
no one wants to talk to me up front.

So, this is another NACK.
