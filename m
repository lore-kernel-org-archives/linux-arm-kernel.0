From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 May 2014 06:44:02 +0900
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
In-Reply-To: <CAD=FV=WKOtZaUyzTWNqR=vi_L=U-Q1dct2U_oCYi3ZJv6401Hg@mail.gmail.com>
References: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
 <53752E25.9060604@gmail.com>
 <CAD=FV=WKOtZaUyzTWNqR=vi_L=U-Q1dct2U_oCYi3ZJv6401Hg@mail.gmail.com>
Message-ID: <53753522.30107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/14 06:33, Doug Anderson wrote:
> Tomasz,
>
> On Thu, May 15, 2014 at 2:14 PM, Tomasz Figa<tomasz.figa@gmail.com>  wrote:
>> Hi Chirantan,
>>
>> On 15.05.2014 23:07, Chirantan Ekbote wrote:
>>> The multi core timer and the ARM architected timer are two different
>>> interfaces to the same underlying hardware timer.  This causes some
>>> strange timing issues when they are both enabled at the same time so
>>> remove the mct from the device tree and keep only the architected
>>> timer.
>>
>> Huh? I've always thought MCT is a completely separate hardware block
>> outside of ARM cores, while architected timers are embedded inside the
>> CPU block in which the ARM cores reside. Could you elaborate on this?
>
> Yup.  Our thoughts exactly.
>
> ...but it appears not to be the case.  Chirantan demonstrated this in
> U-Boot just to prove that it's not some strange kernel interaction in
> <https://chromium-review.googlesource.com/200035>.  I took his patch
> and tweaked it a little more myself in
> <https://chromium-review.googlesource.com/200098>.
>
> Specifically:
> * If you stop the MCT, the arch timer stops
> * If you reset the MCT, the arch timer resets
> * If you start the MCT again, the arch timer starts again
> * If you read the MCT and the arch timer, they give the same value.
>
>
> This is apparently the answer to my question at
> <http://www.spinics.net/lists/linux-samsung-soc/msg29085.html>.
> Specifically Chirantan found that the big jump in time happened when
> MCT reset to 0.  That made the arch timer code think that there was a
> wraparound and jump forward in time a lot.
>
>
> Please confirm if you have a system that has MCT and arch timer in front of you.
>
Hi all,

I need to talk to hardware guy to clarify the issue then I'll let you know.

Thanks,
Kukjin
