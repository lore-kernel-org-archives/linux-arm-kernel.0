From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Apr 2014 01:08:32 -0400
Subject: [PATCH v2 2/4] ARM: mvebu: fix NOR bus-width in Armada XP GP
 Device Tree
In-Reply-To: <1397489361-5833-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397489361-5833-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140417050832.GP28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 05:29:19PM +0200, Thomas Petazzoni wrote:
> The mvebu-devbus driver had a serious bug, which lead to a 8 bits bus
> width declared in the Device Tree being considered as a 16 bits bus
> width when configuring the hardware.
> 
> This bug in mvebu-devbus driver was compensated by a symetric mistake
> in the Armada XP GP Device Tree: a 8 bits bus width was declared, even
> though the hardware actually has a 16 bits bus width connection with
> the NOR flash.
> 
> Now that we have fixed the mvebu-devbus driver to behave according to
> its Device Tree binding, this commit fixes the problematic Device Tree
> files as well.
> 
> This bug was introduced in commit
> da8d1b38356853c37116f9afa29f15648d7fb159 ('ARM: mvebu: Add support for
> NOR flash device on Armada XP-GP board') which was merged in v3.10.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/boot/dts/armada-xp-gp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patches 2, 3, and 4 applied to mvebu/dt-fixes for stable with Gregory
and Ezequiel's Acks.

Also, a gentle nit:  You're doing all the -stable info digging, would
you mind putting it in the following format so I don't have to hand edit
each patch?

------
Link: ...
Fixes: da8d1b383568 ('ARM: mvebu: Add support for NOR flash device on Armada XP-GP board')
Cc: stable at vger.kernel.org # v3.10+
------

thx,

Jason.
