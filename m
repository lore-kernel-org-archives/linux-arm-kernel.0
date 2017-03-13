From: pku.leo@gmail.com (Yang Li)
Date: Mon, 13 Mar 2017 17:23:23 -0500
Subject: [PATCH 3/4] arm: dts: imx: Add iMX6Q-based Kontron SMARC-sAMX6i
 module
In-Reply-To: <20170301002048.GG21222@n2100.armlinux.org.uk>
References: <20170219202801.2082-1-plaes@plaes.org>
 <20170219202801.2082-4-plaes@plaes.org>
 <CAL_JsqJzP5e0fcM==cqkAe=x9Yf+H7i+k1H0udaknY_h6cbOSQ@mail.gmail.com>
 <20170228231010.GD21222@n2100.armlinux.org.uk>
 <CAL_Jsq+9EA72_Om4h3q3dGpDVAdkjDKsSkNU_S+3a81zaU73pA@mail.gmail.com>
 <20170301002048.GG21222@n2100.armlinux.org.uk>
Message-ID: <CADRPPNT6dAPAAKU6bxc0AA=ipFcbbVdcbrUgzd9hW2Nh4Leeyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 6:20 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Feb 28, 2017 at 05:49:57PM -0600, Rob Herring wrote:
>> On Tue, Feb 28, 2017 at 5:10 PM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> > On Tue, Feb 28, 2017 at 05:06:02PM -0600, Rob Herring wrote:
>> >> On Sun, Feb 19, 2017 at 2:28 PM, Priit Laes <plaes@plaes.org> wrote:
>> >> > SMARC-sAMX6i is a SMARC (Smart Mobility Architecture) compliant
>> >> > module.
>> >> >
>> >> > Signed-off-by: Priit Laes <plaes@plaes.org>
>> >> > ---
>> >> >  arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi | 434 ++++++++++++++++++++++++++++++
>> >> >  1 file changed, 434 insertions(+)
>> >> >  create mode 100644 arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi
>> >> >
>> >> > diff --git a/arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi b/arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi
>> >> > new file mode 100644
>> >> > index 0000000..e3d7a35
>> >> > --- /dev/null
>> >> > +++ b/arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi
>> >> > @@ -0,0 +1,434 @@
>> >> > +/*
>> >> > + * Copyright 2017 Priit Laes <plaes@plaes.org>
>> >> > + *
>> >> > + * Based on initial work by Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
>> >> > + *
>> >> > + * This file is dual-licensed: you can use it either under the terms
>> >> > + * of the GPL or the X11 license, at your option. Note that this dual
>> >> > + * licensing only applies to this file, and not this project as a
>> >> > + * whole.
>> >> > + *
>> >> > + *  a) This file is free software; you can redistribute it and/or
>> >> > + *     modify it under the terms of the GNU General Public License as
>> >> > + *     published by the Free Software Foundation; either version 2 of
>> >> > + *     the License, or (at your option) any later version.
>> >> > + *
>> >> > + *     This file is distributed in the hope that it will be useful,
>> >> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >> > + *     GNU General Public License for more details.
>> >> > + *
>> >> > + * Or, alternatively,
>> >> > + *
>> >> > + *  b) Permission is hereby granted, free of charge, to any person
>> >> > + *     obtaining a copy of this software and associated documentation
>> >> > + *     files (the "Software"), to deal in the Software without
>> >> > + *     restriction, including without limitation the rights to use,
>> >> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> >> > + *     sell copies of the Software, and to permit persons to whom the
>> >> > + *     Software is furnished to do so, subject to the following
>> >> > + *     conditions:
>> >> > + *
>> >> > + *     The above copyright notice and this permission notice shall be
>> >> > + *     included in all copies or substantial portions of the Software.
>> >> > + *
>> >> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> >> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> >> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> >> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> >> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> >> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> >> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> >> > + *     OTHER DEALINGS IN THE SOFTWARE.
>> >>
>> >> Use SPDX tags here:
>> >>
>> >> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> >>
>> >> While it says X11, this is really MIT license text.
>> >
>> > No.  Read the FSF's page on licenses:
>> >
>> >    X11 License (#X11License)
>> > ...
>> >            This license is sometimes called the MIT license, but that term is
>> >            misleading, since MIT has used many licenses for software.
>> >
>> > Never use the term "MIT license", it's ambiguous, and I doubt that such
>> > a term (given the above) would stand up in a court of law as identifying
>> > any particular license.
>>
>> The SPDX tags have a very exact, documented meaning. That's the point.
>> X11 means this[1]. MIT means this[2].
>
> Meanwhile, the FSF appears to disagree, so this creates work for
> solicitors (or lawyers if you're in the US) to have a field day.
>
> Also, if it was _this_ easy, we would have included a web URL to
> point at the license text since 1992 - but we haven't because it's
> a level of indirection that brings with it uncertainty.
>
> Now, you could say "oh we worship the LF, we trust them, they're
> never going to do anything stupid, let's trust SPDX to always
> stay the same and exist" but IMHO that's letting emotional
> judgement cloud the legal issue.
>
> There's also very little discussion on spdx.org about the legal
> side of this stuff.
>
> So, to me, this spdx stuff looks like a programmers solution to a
> legal problem, looks completely untested legally, and goes against
> recommended practices (which are to include the copyright plus the
> actual notice of intent - not copyright plus a level of indirection.)
>
> As I said above, if it was this easy, we'd have been linking to
> (eg) fsf.org's copies of license texts for years or similar.
>
> Now, with the FSF.org's different stance on X11 vs MIT compared
> to spdx.org identifying "MIT" differently, I suspect that there
> is ample room here for solicitors/lawyers to make a great deal
> of cash.
>
> Another point here is... if LF and/or SPDX.org goes belly-up, or
> becomes unaccessible, eg, spdx.org's name registration expires and
> gets taken over by a rogue party - at that point, this SPDX stuff
> can mean _anything_.
>
> I do hope those who you've been recommending to use SPDX tags stop
> and think about it, and don't blindly follow what you're suggesting.

So do we have a consensus on this topic?  Right now SPDX id is rarely
used in Linux kernel.  A grep of SPDX in the source code only shows
around 10 appearances.  Whether or not changing to promote the usage
of SPDX id in the future seems to be a good topic for broader
discussion.  And it would be good to have a kernel wide guideline as a
result.  I'm adding Linus Torvalds to the recipient, and hope he can
provide some of his insight to the issue.

Regards,
Leo
