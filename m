From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Thu, 6 Nov 2014 20:47:34 -0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd.dtsi: Fix the microphone route
In-Reply-To: <CAOMZO5ChyTM2_AnSCbi3R9QXzrCYix_wFHP-5FA-6baBSXVgsA@mail.gmail.com>
References: <1415105769-5358-1-git-send-email-fabio.estevam@freescale.com>
 <20141104130803.GM10821@tiger>
 <CAOMZO5ChyTM2_AnSCbi3R9QXzrCYix_wFHP-5FA-6baBSXVgsA@mail.gmail.com>
Message-ID: <20141107044733.GA31643@Alpha>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 10:16:40AM -0200, Fabio Estevam wrote:
> On Tue, Nov 4, 2014 at 11:08 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Tue, Nov 04, 2014 at 10:56:09AM -0200, Fabio Estevam wrote:
> >> Since commit e409dfbfccf9a49 ("ASoC: dapm: Add a few supply widget sanity
> >> checks") the following error is seen:
> >>
> >> imx-wm8962 sound: wm8962 <-> 202c000.ssi mapping ok
> >> imx-wm8962 sound: Connecting non-supply widget to supply widget is not supported (AMIC -> MICBIAS)
> >> imx-wm8962 sound: ASoC: no dapm match for AMIC --> (null) --> MICBIAS
> >> imx-wm8962 sound: ASoC: Failed to add route AMIC -> direct -> MICBIAS
> >
> > Any regression behind that error message?
> 
> Playback works fine, but I am having issues with arecord with or
> without this patch, so I haven't seen any regression.
> 
> Will investigate the arecord problem I am having (maybe it is a
> alsamixer config issue).

I just took a test on imx6sx-sdb with the identical AMIC route
as SabreSD does, but the microphone actually still works even
if the same link error occurs.

So I think the error doesn't break the function on Sabre SD
either...and the reason should be the dts connecting 'IN3R'
directly to MICBIAS, which isn't so accurate.

For the patch, I think the configuration on imx6sx-sdb would
be better.

120                         "AMIC", "MICBIAS",
121                         "IN3R", "AMIC";

Thanks
Nicolin
