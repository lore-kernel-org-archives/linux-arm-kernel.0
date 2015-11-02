From: dhdang@apm.com (Duc Dang)
Date: Mon, 2 Nov 2015 15:26:46 -0800
Subject: [GIT PULL] arm64: Second batch of DTS changes for X-Gene
 platforms queued for v4.4
In-Reply-To: <CAOesGMhcBy5M8Z-t5yz=7vwzAjsY04tTd4DN=ia119xwMU4OJQ@mail.gmail.com>
References: <CADaLND=otWJX5vqzGdf0Y_pwiYHafWB5TwE9GXWnHG3M2r7fOw@mail.gmail.com>
 <CADaLND=9YSB7UaqVKkhwuoVipVUN3mOQCB9cy_=DVf2m6nzOaQ@mail.gmail.com>
 <20151031015437.GE1722@localhost>
 <CADaLNDnSpoJ8+P5z1+p_ms-NPf3qAyTevvvO+93bkricBcvPoA@mail.gmail.com>
 <CAOesGMhcBy5M8Z-t5yz=7vwzAjsY04tTd4DN=ia119xwMU4OJQ@mail.gmail.com>
Message-ID: <CADaLNDm=tHi=uBAfWZbhFQNouZFh8_JRNbBXgG1-6uX9-QFuoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 31, 2015 at 12:22 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Fri, Oct 30, 2015 at 7:15 PM, Duc Dang <dhdang@apm.com> wrote:
>> Hi Olof,
>>
>> On Friday, October 30, 2015, Olof Johansson <olof@lixom.net> wrote:
>>>
>>> Hi Duc,
>>>
>>> On Fri, Oct 30, 2015 at 01:35:54PM -0700, Duc Dang wrote:
>>> > On Wed, Oct 28, 2015 at 12:08 PM, Duc Dang <dhdang@apm.com> wrote:
>>> > > Hi Arnd, Olof,
>>> > >
>>> > > The following changes since commit
>>> > > d2d0a722df735de52015f0c8a01f27a9ec28622e:
>>> > >
>>> > >   arm64: dts: Add poweroff device nodes for APM X-Gene 2 platform
>>> > > (2015-10-12 14:18:38 -0700)
>>> > >
>>> > > are available in the git repository at:
>>> > >
>>> > >   https://github.com/AppliedMicro/xgene-next.git
>>> > > tags/xgene-dts-for-v4.4-2
>>> > >
>>> > > for you to fetch changes up to
>>> > > fa535e2632f275f0d5d4080d60c8e1331ac37549:
>>> > >
>>> > >   arm64: dts: Add L2 cache topology for APM X-Gene SoC (2015-10-26
>>> > > 02:31:43 -0700)
>>> > >
>>> > > ----------------------------------------------------------------
>>> > > Second batch of DTS changes for X-Gene platforms queued for v4.4
>>> > >
>>> > > This patch set adds DTS entries to support various IPs
>>> > > for X-Gene v1 and X-Gene v2 SoC:
>>> > > - X-Gene v1: Enable support for MMC, USB, GPIO controllers,
>>> > >   I2C controller, L2 Cache topology
>>> > > - X-Gene v2: Enable support for MMC, USB, GPIO controller,
>>> > >   I2C controller (with RTC), PCIe controller with GICv2m MSI,
>>> > >   EDAC, L2 Cache topology, TRNG
>>> > >
>>> > > ----------------------------------------------------------------
>>> > > Duc Dang (16):
>>> > >       arm64: dts: Add the arasan mmc DTS entries for APm X-Gene v2 SoC
>>> > >       arm64: dts: X-Gene: Do not reset or enable/disable clock for AHB
>>> > > block
>>> > >       arm64: dts: Add RNG device tree nodes for APM X-Gene v2 platform
>>> > >       arm64: dts: Add v2m MSI frame nodes for APM X-Gene v2 platforms
>>> > >       arm64: dts: Add PCIe node for APM X-Gene v2 platforms
>>> > >       arm64: dts: Add USB nodes for APM X-Gene v1 platforms
>>> > >       arm64: dts: Add USB nodes for APM X-Gene v2 platforms
>>> > >       arm64: dts: Add APM X-Gene v1 SoC GFC GPIO controller DTS
>>> > > entries
>>> > >       arm64: dts: Add APM X-Gene v2 SoC GFC GPIO controller DTS entry
>>> > >       arm64: dts: Add Designware GPIO dts binding for APM X-Gene v1
>>> > > platform
>>> > >       arm64: dts: Add APM X-Gene v2 SoC Designware GPIO controller DTS
>>> > > entry
>>> > >       arm64: dts: Add APM X-Gene v2 SoC EDAC DTS entries
>>> > >       arm64: dts: Add Designware I2C controller DTS entries for X-Gene
>>> > > v1 SoC
>>> > >       arm64: dts: Add Designware I2C controller DTS entries for X-Gene
>>> > > v2 SoC platform
>>> > >       arm64: dts: Add RTC DTS entry for X-Gene v2 SoC platform
>>> > >       arm64: dts: Add L2 cache topology for APM X-Gene SoC
>>> > >
>>> > > Suman Tripathi (1):
>>> > >       arm64: dts: Add the arasan mmc DTS entries for APM X-Gene v1 SoC
>>> > >
>>> > >  arch/arm64/boot/dts/apm/apm-merlin.dts     |  12 +
>>> > >  arch/arm64/boot/dts/apm/apm-mustang.dts    |   4 +
>>> > >  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 401
>>> > > +++++++++++++++++++++++++++++
>>> > >  arch/arm64/boot/dts/apm/apm-storm.dtsi     | 126 +++++++++
>>> > >  4 files changed, 543 insertions(+)
>>> >
>>> > Hi Arnd, Olof,
>>> >
>>> > I am sorry that I sent this pull request late. But do you still have
>>> > some cycle to have this change set pulled into your xgene/dt in
>>> > next/dt for 4.4?
>>>
>>> This is indeed showing up quite late, since the merge window opens in just
>>> a couple of days.
>>>
>>> Can I please ask that you send us a new pull request for this once -rc1 is
>>> out,
>>> and we'll queue it up for 4.5?
>>
>> Yes, I realized the merge window start this Sunday too late.
>>
>> Anyway, do you maintain a general rule like when You expect people send you
>> a pull request for the next merge window? For example: the request must be
>> before rc6?
>
> The sooner the better. Ideally most code should show up sometime
> between rc4 and rc6. After that we will usually take smaller
> incremental branches that adds a few patches on top of previous
> material.
>
> If you have cross-dependencies with other maintainer trees, for
> example due to shared introduced header files, then please try to get
> it in early in case we need to coordinate something.
>
> The community as a whole has a self-imposed limit that most material
> should be in -next by -rc6, but it's not strictly enforced and is seen
> as a guideline.
>
> I think the ARM64 arch maintainers try to get most material in by
> -rc4, but they need slightly more bake/test time on their code so
> that's understandable.
>
>
> Arnd gave a presentation about how we run the maintainer tree at this
> year's ELC, and I gave one two years ago more around how we organize
> our tree. The videos and slides are online and gives a bit of an
> overview if you're interested in learning more.

I looked for and found the slides with Arnd's presentation from Arnd's
Google+ site: https://plus.google.com/+ArndBergmann/posts/C216LKEBHR7

This definitely gave me some very useful information and answer a lot
of questions that I had.

Thanks!
>
>
> -Olof

Duc Dang.
