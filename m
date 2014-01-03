From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Jan 2014 18:41:30 -0800
Subject: DT include files (was: [GIT PULL 2/2] ARM: imx: device tree
 changes for 3.14)
In-Reply-To: <20140103023211.GA25079@S2101-09.ap.freescale.net>
References: <20131231054427.GA22383@S2101-09.ap.freescale.net>
 <20140102202108.GF19720@quad.lixom.net>
 <20140103023211.GA25079@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMheei8YgzfRp9pmQ0rT9zhJ2_hF56j5Y+jLSy5TadPZ-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 2, 2014 at 6:32 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Olof,
>
> On Thu, Jan 02, 2014 at 12:21:08PM -0800, Olof Johansson wrote:
>> >  .../devicetree/bindings/vendor-prefixes.txt        |    3 +
>> >  arch/arm/boot/dts/imx25-pinfunc.h                  |  494 +++++++++++
>> >  arch/arm/boot/dts/imx25-pingrp.h                   |   81 ++
>> >  arch/arm/boot/dts/imx27-pinfunc.h                  |  526 +++++++++++
>> >  arch/arm/boot/dts/imx27-pingrp.h                   |  151 ++++
>> >  arch/arm/boot/dts/imx35-pingrp.h                   |  104 +++
>> >  arch/arm/boot/dts/imx50-pinfunc.h                  |  923 ++++++++++++++++++++
>> >  arch/arm/boot/dts/imx50-pingrp.h                   |  146 ++++
>> >  arch/arm/boot/dts/imx51-pingrp.h                   |  249 ++++++
>> >  arch/arm/boot/dts/imx53-pingrp.h                   |  352 ++++++++
>> >  arch/arm/boot/dts/imx6dl-pinfunc.h                 |    2 +
>> >  arch/arm/boot/dts/imx6q-pinfunc.h                  |    2 +
>> >  arch/arm/boot/dts/imx6qdl-pingrp.h                 |  532 +++++++++++
>> >  arch/arm/boot/dts/imx6sl-pingrp.h                  |  148 ++++
>> >  arch/arm/boot/dts/vf610-pingrp.h                   |  127 +++
>>
>> Hm, these don't quite use include files the way include files were
>> originally meant to be used -- initially the idea was to use them to
>> define mostly simple constants instead of full properties like this.
>
> The DT macro support was introduced to improve the readability of device
> tree sources by replacing those magic numbers with readable macros.  I
> think the usage in imx pinctrl binding perfectly fits the purpose.  You
> can get details of the binding in
> Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt.

To be honest I didn't follow that discussion closely. If DT
maintainers are OK with that style, then I'm OK. :)

>> I'm not against the idea of using it this way, but I also want to make sure the
>> DT maintainers are OK with it. So I've cc:d them on this reply.
>
> This is not a new thing. It was firstly adopted for imx6q in v3.10
> release with commit e164153 (pinctrl: imx: move hard-coding data into
> device tree), which had been posted to devicetree list for sure.  We're
> just moving more i.MX SoCs to it.

Ok, then it's probably just the location of the header files that
should be adjusted. Other subsystems have placed them under
include/dt-bindings/<subsystem>, so that's likely a better place for
these as well, don't you think?

>> I'm also not crazy about the insanely long identifiers used here, but I guess
>> they correlate with some user manual tables?
>
> Yes, the identifiers follows the pad and function names from reference
> manual.

Ok, fair enough.


-Olof
