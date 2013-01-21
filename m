From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 22 Jan 2013 07:33:12 +0800
Subject: [PATCH v7 09/15] gpio: pl061: set initcall level to module init
In-Reply-To: <1358785488.6590.33.camel@hornet>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdb=vf5s-XmfYYn5W-BjeNaf9vw6-sDSH6VDC41PBX0rdQ@mail.gmail.com>
 <1358785488.6590.33.camel@hornet>
Message-ID: <CAD6h2NQ68PpT2z5WkCOdkznhe+ZFOhaZ9=Zpgsy9_Da_2eha=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2013 00:24, Pawel Moll <pawel.moll@arm.com> wrote:
> On Mon, 2013-01-21 at 14:41 +0000, Linus Walleij wrote:
>> On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>
>> > Replace subsys initcall by module initcall level. Since pinctrl
>> > driver is already launched before gpio driver. It's unnecessary
>> > to set gpio driver in subsys init call level.
>> >
>> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>
>> On you platform maybe it works, but have you made sure that nobody
>> else will be affected?
>>
>> SPEAr of course, then these:
>>
>> arch/arm/mach-realview/core.c:           * GPIO on PL061 is active,
>> which is the proper
>> arch/arm/mach-socfpga/Kconfig:  select GPIO_PL061 if GPIOLIB
>>
>> Pawel, Dinh: are you OK with this change?
>
> Hm. Doesn't this make the MMCI probing depending on the module_init
> order? As in: wouldn't it make the mmci probe completely fail (not even
> defer it) if it was called before the pl061? In that case even your,
> Linus, hack with inverting the CD status wouldn't work...
>
> Pawel
>
>
>
The sequence of module probe is pinctrl --> gpio --> mmc. So the dependance
of mmc on gpio isn't broken.

Regards
Haojian
