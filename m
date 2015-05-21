From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 May 2015 10:20:43 +0900
Subject: linux-next: manual merge of the samsung tree with the arm-soc and
 at91 trees
In-Reply-To: <CAMuHMdVoot1mBHUmGMuTzCkxzd7H5TJThrwmPvnedFAOAP49pw@mail.gmail.com>
References: <20150520102743.3d336a73@canb.auug.org.au>
 <CAJKOXPdsi-5kdQJtybeaMCy0DXuRTRGgBEOM=SH9BsjquEMjCQ@mail.gmail.com>
 <20150520091646.GF3338@piout.net>
 <CAMuHMdVoot1mBHUmGMuTzCkxzd7H5TJThrwmPvnedFAOAP49pw@mail.gmail.com>
Message-ID: <CAJKOXPeQEvcUF1NcnSEAMGf5JE2ySftFtP9DHij6siDfzTjPtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-20 18:47 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Wed, May 20, 2015 at 11:16 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> On 20/05/2015 at 09:35:36 +0900, Krzysztof Kozlowski wrote :
>>> 2015-05-20 9:27 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
>>> > Today's linux-next merge of the samsung tree got a conflict in
>>> > arch/arm/configs/multi_v7_defconfig between various commits from the
>>> > arm-soc and at91 trees and various commits from the samsung tree.
>>> >
>>> > I fixed it up (see below) and can carry the fix as necessary (no action
>>> > is required).
>>>
>>> Hi,
>>>
>>> Thanks for the merge.
>>>
>>> The parts coming from samsung-soc related to manually toggling stuff
>>> (by me and Javier) look fine. The rest (coming from Kukjin's
>>> savedefconfig) I don't know - too much of them.
>>>
>>
>> Hum, last time I asked, we were not supposed to do a savedefconfig on
>> multi_v7...
>
> Yeah, IMHO it's something the arm-soc maintainers should do only right
> after rc1.
>
> Doing it at any other point in time may remove options that have just been
> added to multi_v7_defconfig by an arm-soc submaintainer, and that depend on
> a Kconfig change queued in another maintainer's for-next branch.

It also depends on which tree and branch the savedefconfig was
performed. If on Linus' master then probably it is not a good idea at
any time.

> Personally, I think no arm-soc submaintainer should touch multi_v7_defconfig,
> and all changes should be applied by the arm-soc maintainers.

Actually Arnd suggested this:
https://lkml.org/lkml/2015/5/15/303
[PATCH 0/9] multi_v7_defconfig: Enable options for Exynos Chromebooks

Best regards,
Krzysztof
