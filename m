From: w@1wt.eu (Willy Tarreau)
Date: Mon, 3 Jun 2013 19:56:29 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <20130603171017.GN18614@n2100.arm.linux.org.uk>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk>
Message-ID: <20130603175629.GH5008@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jun 03, 2013 at 06:10:18PM +0100, Russell King - ARM Linux wrote:
> You know, my reaction to this is to nack it because:
> 
> (a) Marvell didn't talk to me about adding a new tag.
> (b) There is an established precident that we do not pass MAC addresses
>     to the kernel in this way (such attempts have been rejected in the
>     past.)
> (c) It goes completely against the design spirit of ATAGs by combining
>     many different types and instances of information into one tag.
> (d) It picks a tag ID without understanding how tag IDs are allocated.
>     (the idea is 0x41NNNNVV where NNNN = machine ID for machine specific
>     tags.)
> 
> Everyone who has gone around extending ATAG stuff has made exactly the
> same mistakes time and time again - mostly stemming from the fact that
> no one wants to talk to me up front.
> 
> So, this is another NACK.

I understand your points, but then what could we do to get our devices
to have properly working ethernet interfaces ? These devices have already
been sold, and from what I've seen they've been using this ID since at
least the Kirkwood devices.

I found no other way to get the MAC address once the system is booted.
I would have no problem having some board-spec code locate the atags
and set the MAC, but it looks like the information is lost very early
and is not available anymore soon after the boot (or at least I couldn't
find it anywhere else).

It's really not with happiness that I had to add this part to the ATAGs,
but because I didn't find another solution :-(

Thanks,
Willy
