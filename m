From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 May 2013 10:21:49 +0800
Subject: [PATCH v3] ARM: imx: replicate the diagnostic register of boot
 cpu into secondary cores
In-Reply-To: <20130501163817.GD24055@mudshark.cambridge.arm.com>
References: <1366948645-12060-1-git-send-email-shawn.guo@linaro.org>
 <20130426132130.GE30858@mudshark.cambridge.arm.com>
 <20130426134722.GA1943@S2101-09.ap.freescale.net>
 <5181357E.3090805@gmail.com>
 <20130501153828.GC24055@mudshark.cambridge.arm.com>
 <5181408C.8090606@gmail.com>
 <20130501163817.GD24055@mudshark.cambridge.arm.com>
Message-ID: <20130502022147.GC3442@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 05:38:17PM +0100, Will Deacon wrote:
> On Wed, May 01, 2013 at 05:19:24PM +0100, Dirk Behme wrote:
> > Am 01.05.2013 17:38, schrieb Will Deacon:
> > > On Wed, May 01, 2013 at 04:32:14PM +0100, Dirk Behme wrote:
> > Just for a better understanding: What's wrong with using the same 
> > register values on all CPUx? I.e. with copying them from CPU0? 
> > Shouldn't all CPUx use the same setting? Or at least the same errata 
> > bits enabled?
> 
> There's this thing called big.LITTLE... In this case, we're all A9s, but it
> still feels horrible.

It sounds more like a feeling instead of any issue in real.  Unless I
hear some convincing technical explanation, I will send the patch for
-rc to fix the broken reboot on imx6q.

Shawn
