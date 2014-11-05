From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 5 Nov 2014 10:16:40 -0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd.dtsi: Fix the microphone route
In-Reply-To: <20141104130803.GM10821@tiger>
References: <1415105769-5358-1-git-send-email-fabio.estevam@freescale.com>
 <20141104130803.GM10821@tiger>
Message-ID: <CAOMZO5ChyTM2_AnSCbi3R9QXzrCYix_wFHP-5FA-6baBSXVgsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 4, 2014 at 11:08 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Nov 04, 2014 at 10:56:09AM -0200, Fabio Estevam wrote:
>> Since commit e409dfbfccf9a49 ("ASoC: dapm: Add a few supply widget sanity
>> checks") the following error is seen:
>>
>> imx-wm8962 sound: wm8962 <-> 202c000.ssi mapping ok
>> imx-wm8962 sound: Connecting non-supply widget to supply widget is not supported (AMIC -> MICBIAS)
>> imx-wm8962 sound: ASoC: no dapm match for AMIC --> (null) --> MICBIAS
>> imx-wm8962 sound: ASoC: Failed to add route AMIC -> direct -> MICBIAS
>
> Any regression behind that error message?

Playback works fine, but I am having issues with arecord with or
without this patch, so I haven't seen any regression.

Will investigate the arecord problem I am having (maybe it is a
alsamixer config issue).
