From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Apr 2013 15:49:03 -0600
Subject: [GIT PULL 7/8] ARM: tegra: multi-platform conversion
In-Reply-To: <201304092201.18950.arnd@arndb.de>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-7-git-send-email-swarren@wwwdotorg.org>
 <201304091659.08376.arnd@arndb.de> <201304092201.18950.arnd@arndb.de>
Message-ID: <51648CCF.80902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2013 02:01 PM, Arnd Bergmann wrote:
> On Tuesday 09 April 2013, Arnd Bergmann wrote:
>> On Friday 05 April 2013, Stephen Warren wrote:
>>> This branch converts Tegra to support multi-platform/single-zImage.
> 
>> I had to reorder the branches in arm-soc to avoid starting a
>> next/multiplatform2 branch, but I saw nothing that prevents us from
>> having multiplatform after soc.
> 
> I've applied this patch on top.
...
> Subject: [PATCH] ARM: tegra: build assembly files with -march=armv7-a
> 
> The tegra assembly files are written for ARMv7 and are not compatible
> with ARMv6, which leads to build warnings when compiling a dual
> ARMv6/v7 kernel. Since this code is only ever run on Tegra ARMv7
> hardware, we can tell the assembler which architecture level to
> use.

Ah yes, I hit that problem too, but wasn't sure how to solve it. The
patch below looks good. Now I must go try a combo bcm2835+Tegra kernel
on both devices...
