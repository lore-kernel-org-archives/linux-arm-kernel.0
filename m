From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jul 2012 09:54:33 -0600
Subject: [PATCH] ARM: ux500: Register pinctrl from platform code until
 it's been DT:ed
In-Reply-To: <4FF56029.2060007@linaro.org>
References: <1341412452-3808-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdb1rZQWpuUxQoxqg2eYanf4tnm0SmFkQQBwvSuyYV00Gw@mail.gmail.com>
 <4FF56029.2060007@linaro.org>
Message-ID: <4FF5B8B9.8030200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2012 03:36 AM, Lee Jones wrote:
> On 05/07/12 09:55, Linus Walleij wrote:
...
>> There are plenty of
>> examples of how to do this in for example:
>> arch/arm/boot/dts/tegra-seaboard.dts
> 
> I don't see this file anywhere?

It was recently renamed to tegra20-seaboard.dts.

While Tegra doesn't need any AUXDATA for the pinctrl driver specifically
(since we're purely initializing pinctrl from DT now when booting with
DT), we do need AUXDATA for other devices mainly for clocks. You can
find the AUXDATA setup in:

arch/arch/mach-tegra/board-dt-tegra*.c
