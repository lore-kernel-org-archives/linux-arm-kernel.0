From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Jul 2018 07:46:34 -0700
Subject: [PATCH 12/15] arm: dts: highbank: Add missing OPP properties for
 CPUs
In-Reply-To: <20180703041321.k2ewqta76cnqhsmm@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <f8a4e5c3062397736475ec599de730206846cb9b.1527244201.git.viresh.kumar@linaro.org>
 <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
 <20180702232735.eocdrdfwyj37577h@localhost>
 <20180703041321.k2ewqta76cnqhsmm@vireshk-i7>
Message-ID: <CAOesGMjtFSVg1yu-9TAxXTTtvzGaUGn6P9-hnK5XrgHVFVHDOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 9:13 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 02-07-18, 16:27, Olof Johansson wrote:
>> On Mon, Jul 02, 2018 at 02:25:40PM -0600, Rob Herring wrote:
>> > On Fri, May 25, 2018 at 4:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > >
>> > > The OPP properties, like "operating-points", should either be present
>> > > for all the CPUs of a cluster or none. If these are present only for a
>> > > subset of CPUs of a cluster then things will start falling apart as soon
>> > > as the CPUs are brought online in a different order. For example, this
>> > > will happen because the operating system looks for such properties in
>> > > the CPU node it is trying to bring up, so that it can create an OPP
>> > > table.
>> > >
>> > > Add such missing properties.
>> > >
>> > > Fix other missing property (clock latency) as well to make it all
>> > > work.
>> > >
>> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > > ---
>> > >  arch/arm/boot/dts/highbank.dts | 30 ++++++++++++++++++++++++++++++
>> > >  1 file changed, 30 insertions(+)
>> >
>> > Acked-by: Rob Herring <robh@kernel.org>
>> >
>> > ARM-SOC maintainers, Please apply this.
>>
>> Applied to next/dt.
>
> Thanks Olof.
>
> Can you also apply other patches in this series, that haven't been
> applied yet by SoC maintainers ? And same for the arm64 series..

This is the kind of patch that should be applied by the maintainers
for active platforms, where they have systems to test with and can
make sure you haven't regressed something on them.

For very low patch rate platforms we can apply directly through
maintainer acks, like in this case.

So, my recommendation is to repost the series to the maintainers.
Please don't patchbomb arm at kernel.org though, so keep us off of cc by
default (you can add our individual addresses if you want).


Thanks,

-Olof
