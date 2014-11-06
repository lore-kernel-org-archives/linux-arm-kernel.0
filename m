From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Nov 2014 21:16:03 +0100
Subject: [RFC PATCH] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <545BD274.6050103@alliedtelesis.co.nz>
References: <1415249396-2985-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141106155823.213f8811@free-electrons.com>
 <545BD274.6050103@alliedtelesis.co.nz>
Message-ID: <20141106201603.GF4974@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Darn. I thought that might be the case but I wanted to keep the scope of 
> my change small. How about making setup_arch check if smp_ops is already 
> set?

I think that would be last resort solution. Try not to touch core code
unless you really have to.

> Alternatively if we gave ARMADA_370_XP_DT a smp_init function that
> returned non-zero if smp_ops is already set then I think it'd be
> backwards compatible and keep the scope of the change restricted to
> the 370-XP platforms.

This sounds more reasonable.

     Andrew
