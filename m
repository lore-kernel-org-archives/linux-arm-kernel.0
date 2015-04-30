From: olof@lixom.net (Olof Johansson)
Date: Thu, 30 Apr 2015 09:50:03 -0700
Subject: [RFT PATCH] drm/exynos: Enable DP clock to fix display on
 Exynos5250 and other
In-Reply-To: <55425AFB.8020904@collabora.co.uk>
References: <1427471856-20918-1-git-send-email-k.kozlowski@samsung.com>
 <7h8udau9he.fsf@deeprootsystems.com>
 <CAJKOXPc6Epy_L+djManggcaYLaOrQ_c2S0=_GgU=dikuY1UU0g@mail.gmail.com>
 <7h8ud9pqmm.fsf@deeprootsystems.com>
 <CAOesGMiHbcVK+BjiidPphGuoETyUroXtKgKqcVEgdSBiZQ+GmQ@mail.gmail.com>
 <55425AFB.8020904@collabora.co.uk>
Message-ID: <CAOesGMiA7DCGCg2xgLwu_r_rRYKUjpw2HUePCW5Q9ewU61WbdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 9:40 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Olof,
>
> On 04/30/2015 05:57 PM, Olof Johansson wrote:
>> On Thu, Apr 30, 2015 at 8:44 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
>>>>>>
>>>>>> This should fix issue reported by Javier [1][2].
>>>>>>
>>>>>> Tested on Chromebook Snow (Exynos 5250). More testing would be great,
>>>>>> especially on other Exynos 5xxx products.
>>>>>
>>>>> I hoped to try this on my exynos5 boards, but it doesn't seem to apply
>>>>> to linux-next or to Linus' master branch.
>>>>>
>>>>> Are there some other dependencies here?
>>>>
>>>> It is already applied:
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1c363c7cccf64128087002b0779986ad16aff6dc
>>>
>>> Er, yup.  That would explain it. ;)
>>>
>>> Sorry for the noise,
>>
>> Well, noise or not, Exynos is still broken in mainline and was broken
>> on -next for so long in different ways that bisecting it is a futile
>> exercise in frustration.
>>
>> It doesn't seem to show up with a trivial boot using only ramdisk, but
>> when booting a real distro from disk, it certainly does.
>>
>> For example:
>>
>> http://arm-soc.lixom.net/bootlogs/mainline/v4.1-rc1-56-g3d99e3f/pi-arm-exynos_defconfig.html
>>
>> Disabling CONFIG_DRM makes it boot reliably.
>>
>> Arndale doesn't show it for me, but it also doesn't have working graphics.
>>
>
> Both Exynos5250 and Exynos5420 had similar issues and $subject is the fix
> for 5250 while 5420 is fixed by my "ARM: dts: Make DP a consumer of DISP1
> power domain on Exynos5420" patch that was posted a long time ago. I have
> pinged Kukjin several times about this patch and he said that he will pick
> it this weekend [0].
>
> It is indeed very frustrating how many Exynos patches seems to be falling
> through the crack, even important fixes like these ones that allow boards
> to boot again.
>
> Kevin suggested that Krzysztof could collect and queue patches [1] to help
> Kukjin and start acting as a co-maintatiner which I think it's a very good
> idea and Krzysztof already did for some patches during the 4.1 cycle.

Yes, that's a much needed improvement. I suggest starting out by
collecting critical fixes like these, and we'd be happy to merge them
directly if going through Kukjin will add latency.

Krzysztof, if you can, make sure you get a PGP key setup and start
collecting signatures from kernel developers.


-Olof
