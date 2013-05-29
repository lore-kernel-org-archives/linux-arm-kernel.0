From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 May 2013 19:02:48 -0700
Subject: Single zImage and A15/LPAE
In-Reply-To: <alpine.LFD.2.03.1305282148560.1918@syhkavp.arg>
References: <50735B75.8070109@wwwdotorg.org>
 <alpine.LFD.2.02.1210082201470.16518@xanadu.home>
 <2043931.InXdkgrjkp@wuerfel> <20121009141736.GB2122@linaro.org>
 <180001ce5c03$60cbcf70$22636e50$%kim@samsung.com>
 <alpine.LFD.2.03.1305282148560.1918@syhkavp.arg>
Message-ID: <CAOesGMh+XHueA0UtnAzYTkysqdLqs93Bp31KJKsqVBa-LkiQbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 6:54 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 29 May 2013, Kukjin Kim wrote:
>> (+ Olof, Russell)
>>
>> Just note, I found this in my old mail-box...
>>
>> So I think, as a result, we need to support separate kernel binary for LPAE
>> and non-LPAE and you guys don't hold a different view about it.
>
> LPAE and non-LPAE configurations will most likely never be supported
> together in the same kernel binary.  The runtime cost would simply be
> too high to be worth it.
>
>> Current SSDK5440 and SD5v1 boards which are reference boards for EXYNOS5440
>> has over 4GB memory as a default and that's why I'm writing this e-mail. It
>> means I should keep separated kernel to support exynos5440 and other exynos
>> SoCs.
>
> They could all be supported together but with less than 4GB of memory.

Or the other way around, the other EXYNOS5 CPUs could all enable LPAE
even if they have less than 4GB of memory -- but not EXYNOS4, of
course.

However, instead of forking off and duplicating otherwise
near-identical defconfigs, I suggest just getting your developers used
to passing in CONFIG_LPAE=y on the build command line instead (or in
their local configs for their products, of course). That way there's
less duplication and no need to enable drivers in two places, etc.



-Olof
