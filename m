From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 18 Jan 2015 17:29:58 +0100
Subject: [PATCH] bus: mvebu-mbus: fix support of MBus window 13
In-Reply-To: <1421596214-15924-1-git-send-email-andrew@lunn.ch>
References: <1419943428-18491-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1421596214-15924-1-git-send-email-andrew@lunn.ch>
Message-ID: <20150118172958.0fc11eb5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 18 Jan 2015 16:50:14 +0100, Andrew Lunn wrote:
> On Armada XP, 375 and 38x the MBus window 13 has the remap capability,
> like windows 0 to 7. However, the mvebu-mbus driver isn't currently
> taking into account this special case, which means that when window 13
> is actually used, the remap registers are left to 0, making the device
> using this MBus window unavailable.
> 
> As a minimal fix for stable, don't use window 13. A full fix will
> follow later.
> 
> Fixes: fddddb52a6c ("bus: introduce an Marvell EBU MBus driver")
> Cc: <stable@vger.kernel.org> # v3.10+
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Thanks a lot for doing this!

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
