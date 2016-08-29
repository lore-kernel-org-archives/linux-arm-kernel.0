From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Aug 2016 12:14:38 +0200
Subject: [PATCH] dmaengine: mv_xor: Add support for IO (PCIe) src/dst areas
In-Reply-To: <940069ae-25eb-9106-ac41-300e1730d833@denx.de>
References: <201608241240.aEXnCS9C%fengguang.wu@intel.com>
 <b8c09619-22a5-a677-8841-9760c275a618@denx.de>
 <20160824144314.18928e13@free-electrons.com>
 <940069ae-25eb-9106-ac41-300e1730d833@denx.de>
Message-ID: <20160829121438.7b9ecf7a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 29 Aug 2016 12:07:16 +0200, Stefan Roese wrote:

> As you've probably already noticed, v2 of this patch with
> COMPILE_TEST removed also did run into this linking problem -
> for ARM64 in this case. So its perhaps best to provide this MBus
> driver stub function. COMPILE_TEST could then be enabled again.

Yes, I noticed.

> What do you think? Should I post a separate patch to the MBus
> driver (also attached)? Or should I squash it into v3 of this
> XOR DMA driver patch (with COMPILE_TEST added gain)?

Submitting as a separate patch is better IMO, it's touching a separate
driver. Just submit both in the same patch series, the kbuild test
robot will then only test building the XOR change with the MBus change
applied.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
