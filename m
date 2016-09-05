From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 05 Sep 2016 13:39:49 +0200
Subject: [PATCH] ARM: dts: exynos: Add entries for sound support on
 Odroid-XU board
In-Reply-To: <05c45777-732b-3701-36dc-2448003acd50@samsung.com>
References: <1471883654-2113-1-git-send-email-s.nawrocki@samsung.com>
 <05c45777-732b-3701-36dc-2448003acd50@samsung.com>
Message-ID: <a094364a-b189-5756-ebaf-5f83099d56a4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2016 08:42 AM, Krzysztof Kozlowski wrote:
> Except the name and assigned clocks, this looks the same as
> exynos5422-odroidxu3-audio.dtsi. How about combining them? The name
> could be the same and the assigned-clocks maybe have to be applied to
> XU3 as well?

I could move assigned-clock* properties to the audi2s0 node but on Odroid 
XU the audio CODEC is on different I2C bus, there is very little in common
left.  XU3 already has its assigned-clocks specified and the are subtle
differences, it took me some time to figure out the right settings for XU,
you need to be careful with them!
Given that Odroid XU uses different SoC and there are differences in the
board layout I wouldn't bother with reusing exynos5422-odroidxu3-audio.dtsi
for XU.

--
Thanks, 
Sylwester
