From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 24 Feb 2017 09:07:13 -0600
Subject: [PATCH V2 1/3] arm64: dts: Add basic DT to support Spreadtrum's
 SP9860G
In-Reply-To: <20170224075725.GA32714@spreadtrum.com>
References: <1487660104-15693-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487660104-15693-2-git-send-email-chunyan.zhang@spreadtrum.com>
 <CAL_JsqJ-VXB8pJw3r_fi9Lbmat2dqH-1jmGy8ibK8=PnoZ-c=Q@mail.gmail.com>
 <20170224075725.GA32714@spreadtrum.com>
Message-ID: <CAL_Jsq+3JYQsDo92Azf5MX19=QQUEHu=3PYk2U5keACO5rSDrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 1:57 AM, Chunyan Zhang
<chunyan.zhang@spreadtrum.com> wrote:
> On ?,  2? 23, 2017 at 06:00:20?? -0600, Rob Herring wrote:
>> On Tue, Feb 21, 2017 at 12:55 AM, Chunyan Zhang
>> <chunyan.zhang@spreadtrum.com> wrote:
>> > From: Orson Zhai <orson.zhai@spreadtrum.com>
>> >
>> > SC9860G is a 8 cores of A53 SoC with 4G LTE support SoC from Spreadtrum.
>> >
>> > According to regular hierarchy of sprd dts, whale2.dtsi contains SoC
>> > peripherals IP nodes, sc9860.dtsi contains stuff related to ARM core stuff
>> > and sp9860g dts is for the board level.
>> >
>> > Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
>> > Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> > ---
>> >  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
>> >  arch/arm64/boot/dts/sprd/sc9860.dtsi      | 531 ++++++++++++++++++++++++++++++
>> >  arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |  56 ++++
>> >  arch/arm64/boot/dts/sprd/whale2.dtsi      |  70 ++++
>> >  4 files changed, 659 insertions(+), 1 deletion(-)
>> >  create mode 100644 arch/arm64/boot/dts/sprd/sc9860.dtsi
>> >  create mode 100644 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
>> >  create mode 100644 arch/arm64/boot/dts/sprd/whale2.dtsi
>> >
>> > diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
>> > index b658c5e..f0535e6 100644
>> > --- a/arch/arm64/boot/dts/sprd/Makefile
>> > +++ b/arch/arm64/boot/dts/sprd/Makefile
>> > @@ -1,4 +1,5 @@
>> > -dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb
>> > +dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
>> > +                       sp9860g-1h10.dtb
>> >
>> >  always         := $(dtb-y)
>> >  subdir-y       := $(dts-dirs)
>> > diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> > new file mode 100644
>> > index 0000000..73deb4e
>> > --- /dev/null
>> > +++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> > @@ -0,0 +1,531 @@
>> > +/*
>> > + * Spreadtrum SP9860 SoC DTS file
>> > + *
>> > + * Copyright (C) 2016, Spreadtrum Communications Inc.
>> > + *
>> > + * This file is licensed under a dual GPLv2 or X11 license.
>>
>> Please use SPDX-License-Identifier tag instead.
>>
>
> Just to double check, if I use it like:
>
> SPDX-License-Identifier: (GPL-2.0 or X11)
>
> Is this what you mean?

Yes. However, X11 is not actually correct (pretty much all dts files
have it wrong). This is the X11 license[1] which is explicitly for the
X Consortium and has a couple of extra clauses. While the MIT
license[2] is the text that most dts files actually use (while also
stating X11 license). It's obvious that everyone just copies and
pastes the license and has not consulted their lawyers.

> Will this file still be licensed under the same terms it was, right?

Consult your lawyer. :)

[...]

>> > +               ext_26m: ext-26m {
>>
>> This should be at the top-level. It is not part of the bus.
>
> This clock node is in 'soc' node, not under 'ap-apb'.  Since there're other
> clocks on SC9860 which would have 'reg' property, we thought this fixed
> clock would be better under 'soc' with other clocks.

But the clock is part of the board, not the soc. Or to put it another
way, it's not related to anything else, so it shouldn't be a child of
anything.

Rob

[1] https://spdx.org/licenses/X11.html
[2] https://spdx.org/licenses/MIT.html
