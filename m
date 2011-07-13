From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 13 Jul 2011 12:19:02 +0000
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <20110713115711.GG1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Wednesday, July 13, 2011 7:57 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; lrg at ti.com; linux-arm-
> kernel at lists.infradead.org; u.kleine-koenig at pengutronix.de
> Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
> 
> Which version of the codec do you have? I have:
Yes, it is revision 17.

> [    0.370000] sgtl5000 0-000a: sgtl5000 revision 17
> [    0.370000] sgtl5000 0-000a: asoc: failed to probe CODEC sgtl5000.0-
> 000a: -22
> [    0.380000] asoc: failed to instantiate card mxs_sgtl5000: -22
> 
> The failure is because CONFIG_REGULATOR is not set and it thus fails in
> the
> codec-driver:
> 
> #else /* CONFIG_REGULATOR */
> static int ldo_regulator_register(struct snd_soc_codec *codec,
> 				struct regulator_init_data *init_data,
> 				int voltage)
> {
> 	return -EINVAL;
> }
> 
> (I can patch it to load properly, but well...)
> 
> Proper regulator support for mxs is not in mainline yet. Is that planned?
> How do you do it?

Yes, it's not in mainline yet.
Fixed regulator may be a method.
However currently I just removed VDDIO and VDDA checking in sgtl5000 driver.
Additionally, it seems sgtl5000 driver still needs another fix to get it running.
I copy the patch as below for your info(Just for test).
I'm going to do that in my following work.

Regards
Dong Aisheng
