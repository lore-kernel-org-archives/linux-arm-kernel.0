From: olalilja@yahoo.se (Ola Lilja)
Date: Thu, 2 Aug 2012 07:58:24 +0200
Subject: [PATCH 1/6] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
In-Reply-To: <20120801132022.GS11892@opensource.wolfsonmicro.com>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
 <5017F68B.3060400@linaro.org>
 <20120731151819.GC4468@opensource.wolfsonmicro.com>
 <5018D880.5090306@linaro.org>
 <20120801132022.GS11892@opensource.wolfsonmicro.com>
Message-ID: <003901cd7073$d49cacc0$7dd60640$@se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: den 1 augusti 2012 15:20
> To: Lee Jones
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> STEricsson_nomadik_linux at list.st.com; linus.walleij at stericsson.com;
> arnd at arndb.de; olalilja at yahoo.se; ola.o.lilja at stericsson.com; alsa-
> devel at alsa-project.org; lrg at ti.com
> Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force
> all subsequent widgets to fail too
> 
> On Wed, Aug 01, 2012 at 08:19:28AM +0100, Lee Jones wrote:
> > On 31/07/12 16:18, Mark Brown wrote:
> 
> > >I'm not going to apply this patch.  This isn't a vendor BSP, we
> > >shouldn't be putting random hacks like this in core code.
> 
> > BSP kernel or otherwise, it still seems wrong to me to fail and
> entire
> > audio driver just because of a broken link.
> 
> No, really.  Random disconnections in the DAPM graph are just endless
> pain from a support and debug point of view.  This isn't something that
> randomly breaks on specific hardware where we'd expect random errors at
> runtime, it's something that will never have worked - it seems clear
> nobody tested the mainline submission.
> 
> It's very disappointing to see such an error exist, and even more
> disappointing that there's no interest in fixing the driver.

(Yes, I know this mailer isn't configured correctly, but I'm on vacation
and have no Linux-computer/community-mailer available. However I find it
important to answer this)
Mark, you very well know that I have put in a lot of effort in getting our
Ux500-driver mainlined. This is something I have driven without really
getting sanctioned directly at working, rendering it even harder to find
time for it.
Accusing me of having "no interest in fixing the driver" is just absurd
regarding the time I've spent on this. I'm also still driving for
mainlining our upcoming drivers, so there is no lack of interest, nor lack
of activity at our side. I really think you could afford a bit more polite
attitude when doing reviews. It is not easy to fulfill every single aspect
of mainlining directly and there is (most likely) no one that purposely do
break any community rules. At least not from my side.

Regarding the problem with the failing DAPM-widget I can probably guess
What is going wrong when Lee is trying it out. There will be two failing
clock-supply widgets due to the fact that on the mainline-code these
clocks simply is not there yet. I have, of course, tested this driver
before submitting it, and I wouldn't dream on submitting a driver where
there were failing widgets/routes. Internally, I have put a patch with our
clock-tree for Ux500 on, but this is not mainline-quality code and that is
why it is not submitted with the other patches I sent. The clocks are in
the moment of writing being worked on by other persons in ST-Ericsson, and
I would not have had any time to be doing all this which is not in the
scope of my responsibilities (which is the audio-domain).
Before you told me to create the clock-supply widget-type, I had only
warnings for these failing clocks, as an intermediate solution, before
the clock-tree was submitted, but now they are implemented with the clock-
supply-type and there will be route-errors instead.
Linus W. could probably shed some light of when the missing clocks are to
be submitted.

Regards,
Ola
