From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 30 Apr 2012 13:11:26 +0100
Subject: [PATCH] ARM: cache-l2x0.c: save aux ctrl for resume in case
 that l2x0 is enabled before init
In-Reply-To: <4F9B8D1C.6090400@marvell.com>
References: <4F99148B.4020900@marvell.com> <20120426094400.GD18136@arm.com>
 <4F991ED6.8060109@marvell.com> <20120426102815.GE18136@arm.com>
 <4F9924FB.7070308@marvell.com> <20120426103840.GA6294@arm.com>
 <4F9927F2.5060408@marvell.com> <20120426105651.GB6294@arm.com>
 <4F992B80.6040207@marvell.com> <4F9B8D1C.6090400@marvell.com>
Message-ID: <20120430121125.GN10632@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 07:24:28AM +0100, Yilu Mao wrote:
> Do you agree with this patch to be merged?

I would rather re-read the aux_ctrl register again after it was set (if
L2 is disabled) and store this value. It makes sense if some of the bits
are reserved, at least we have the real value.

-- 
Catalin
