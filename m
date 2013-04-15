From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 15 Apr 2013 19:20:36 +0200
Subject: [PATCH 1/7] clk: exynos: prepare for multiplatform
In-Reply-To: <201304151035.09583.arnd@arndb.de>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
 <1365775405-115297-2-git-send-email-arnd@arndb.de>
 <CAJuYYwRfoU1y_3qbZtdhdyRugPD_QCYWr_LuesOXzq+-jmxouw@mail.gmail.com>
 <201304151035.09583.arnd@arndb.de>
Message-ID: <516C36E4.1090505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 10:35 AM, Arnd Bergmann wrote:
> On Monday 15 April 2013, Thomas Abraham wrote:
>> On 12 April 2013 19:33, Arnd Bergmann <arnd@arndb.de> wrote:
>>> The new common clock drivers for exynos are using compile
>>> time constants and soc_is_exynos* macros to provide backwards
>>> compatibility for pre-DT systems, which is not possible with
>>> multiplatform kernels. This moves all the necessary
>>> information back into platform code and removes the mach/*
>>> header inclusions.
>>
>>
>> Since kgene has submitted a patch to remove pre-dt Exynos support
>> which looks like it will be accepted, we could just remove the use of
>> soc_is_xyz() instead of continuing to support non-dt Exynos.
> 
> I think based on the most recent discussion, we are not actually doing
> that for 3.10, since there are still people that require ATAGS support.

It seems patches from Tomasz [1] will likely make it to 3.10, thus
it is fine to apply Kukjin's patch as far as we are concerned.

Besides, it seems some drivers are already broken with ATAGS booting
(e.g. Exynos DRM, SDHCI) due to introduction of the common clock
framework driver. It doesn't seem worthwhile to spend time fixing
this, I would rather focus on improving the DT support.

Sorry for any confusion.

[1] http://www.spinics.net/lists/arm-kernel/msg238387.html

Sylwester
