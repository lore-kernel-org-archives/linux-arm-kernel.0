From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Aug 2010 16:17:44 +0100
Subject: [PATCH 5/5] ASoc: add machine driver for 88pm860x
In-Reply-To: <AANLkTimWSCwUjE3Xw304DFGyP9VXXi_YT3R4fM_tvdm1@mail.gmail.com>
References: <AANLkTikpcA0RTxdGne2L5n06d0AjfnWEMsh0GP8nvyO6@mail.gmail.com>
	<20100813142646.GE6449@rakim.wolfsonmicro.main>
	<AANLkTimWSCwUjE3Xw304DFGyP9VXXi_YT3R4fM_tvdm1@mail.gmail.com>
Message-ID: <20100813151744.GD11661@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 11:01:36PM +0800, Haojian Zhuang wrote:
> On Fri, Aug 13, 2010 at 10:26 PM, Mark Brown

> >> From cd2063f68b233a86b24efa3f4dc3ca3c438b1576 Mon Sep 17 00:00:00 2001
> >> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> Date: Thu, 12 Aug 2010 12:04:23 +0800

> > Please fix your configuration for sending patches - none of this header
> > stuff should be in the body of the mail.

> Oh. It seems wrong date. Do you know how to resolve this?

Using git send-email to send patches is the easiest thing, if you're
copying into the body of the message then just dropping this block from
the patch when you're pasting it in will usually do the trick.

> >> + ? ? SND_SOC_DAPM_SPK("Board Speaker", NULL),
> >> + ? ? SND_SOC_DAPM_MIC("Board Mic 1", NULL),
> >> + ? ? SND_SOC_DAPM_MIC("Board Mic 3", NULL),

> > What happened to Mic 2?

> Mic 2 is in headset. I declared it with "Mic Jack" in DAPM.

Ah, OK.  Might be clearer if you said something more like:

+ ? ? SND_SOC_DAPM_MIC("Board Mic 1", NULL),
+ ? ? SND_SOC_DAPM_MIC("Mic Jack", NULL),
+ ? ? SND_SOC_DAPM_MIC("Board Mic 3", NULL),

so it's easier to work out where the second jack went.
