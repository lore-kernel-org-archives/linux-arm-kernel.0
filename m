From: w@1wt.eu (Willy Tarreau)
Date: Tue, 13 May 2014 09:22:45 +0200
Subject: [PATCH 0/2] ARM: mvebu: fix PCIe/mvebu-soc-id issue
In-Reply-To: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140513072245.GA29277@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 04:11:38PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of two patches (and more specifically the second patch) fix a
> PCIe detection problem caused by the introduction of the mvebu-soc-id
> and a bad interaction between the clock manipulation done by the
> mvebu-soc-id code and the PCIe driver. The details are all in the
> commit log of the second patch.
> 
> This second patch fixes a PCIe detection problem noticed by several
> persons. The first patch is just a related preparation patch.
> 
> Both patches are meant for 3.15-rc, and should be backported to 3.14
> as part of the stable process.

Both tested on 3.14.3, they work perfectly as expected on mirabox with
igb, and on XP-GP with igb, r8169 and myri10ge, including a dual-port
one with a PCIe bridge onboard.

If you want you can add :

   Tested-by: Willy Tarreau <w@1wt.eu>

Good job!
Willy
