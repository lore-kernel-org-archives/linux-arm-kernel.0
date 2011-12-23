From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 23 Dec 2011 22:42:35 +0800
Subject: [PATCH] regulator: max8925: fix enabled/disabled judgement mistake
In-Reply-To: <20111222143803.GB4546@opensource.wolfsonmicro.com>
References: <1324543892-32540-1-git-send-email-haojian.zhuang@marvell.com>
 <20111222105357.GC4546@opensource.wolfsonmicro.com>
 <CAN1soZy+hgW2iaQad9gbis7bHLCnfQhMKx-JTJc1j2++eRrJyw@mail.gmail.com>
 <20111222134415.GU4546@opensource.wolfsonmicro.com>
 <CAN1soZwBX3x5fiLrLwcC_xTSPMuXw4=u5Rj_CF_R_V3attNzYA@mail.gmail.com>
 <20111222143803.GB4546@opensource.wolfsonmicro.com>
Message-ID: <CAN1soZz=LH2d5-A_y+1kw9mGY0sG2aBj5n=h-dtGU2aGPvDK3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 10:38 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 22, 2011 at 10:22:17PM +0800, Haojian Zhuang wrote:
>
>> While we enable/disable the LDO in software, we'll force LDO into I2C mode
>> and enable/disable the control bit. So there's no risk in the
>> enable/disable function.
>
> Oh, dear. ?That code really is obscure - it's got a shift called
> enable_bit but actually it's mostly working with bitfields not just a
> single bit. ?Reading the enable() and disable() functions it looks like
> they're setting a single bit but that's not the case.
>
> Please send a patch fixing this.
>
>> There's only potential issue of checking whether LDO is enabled. If
>> sequence matches
>> the power sequence (not I2C mode), LDO will be enabled even the
>> control bit is OFF.
>> So this patch is necessary.
>
> I'm not saying the patch isn't required, I'm saying it's very hard to
> work out what the patch is supposed to do and why it's only an issue in
> the is_enabled() function.
>
> Please resend with an improved changelog.

Sure. We'll format a new version.
