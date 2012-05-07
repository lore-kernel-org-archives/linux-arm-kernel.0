From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 7 May 2012 18:00:15 -0400
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <4FA3DC27.6030204@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org> <20120425185747.GC24211@n2100.arm.linux.org.uk>
 <4FA29E46.6040204@linaro.org> <20120503151253.GE897@n2100.arm.linux.org.uk>
 <4FA2A4A8.9010208@linaro.org> <20120503163008.GF897@n2100.arm.linux.org.uk>
 <4FA2B4A3.2040402@linaro.org> <20120503164501.GG897@n2100.arm.linux.org.uk>
 <8762cdur7o.fsf@laptop.org> <4FA3D720.7010004@linaro.org>
 <87mx5ot6vp.fsf@laptop.org> <4FA3DC27.6030204@linaro.org>
Message-ID: <CAP=VYLoLgLmwWTWrJrMBCRLD_BjupjmfV2me6TDeej=ZS=W7hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 9:39 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 04/05/12 14:26, Chris Ball wrote:
>>
>> Hi,
>>
>> On Fri, May 04 2012, Lee Jones wrote:
>>>
>>> I can either do that, or push it through Arnd's tree if you like (and
>>> it's okay with him), as I will be supplying him with another pull
>>> request after my next patch-set has been scrutinised. Would that suit
>>> you better?
>>
>>
>> If the MMC patches are self-contained and it doesn't break anything to

Hi All,

The version of these patches that just appeared in linux-next is causing
build fails on about 5 different configs (versatile_defconfig etc).

It isn't hard to see (with hindsight) that the new function is declared in
an #ifdef CONFIG_OF block, but it's callers are not similarly guarded.
So you get things like this:

http://kisskb.ellerman.id.au/kisskb/buildresult/6272348/

If you can get a fixed up version into the linux-next queue ASAP, that
would be great.

Thanks,
Paul.
--


>> merge them separately, my preference is to merge them via the MMC tree
>> (to avoid creating conflicts against other MMC patches in there).
>>
>> If there are dependencies, going via Arnd instead is fine.
>
>
> Okay, I'll knock up a small patch-set and send it to you.
>
> I think it's 3 patches.
>
>
> --
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> M: +44 77 88 633 515
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
