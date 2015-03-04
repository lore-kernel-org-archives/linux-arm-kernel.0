From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 04 Mar 2015 15:59:55 +0900
Subject: [PATCH v4 2/8] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <13467157.nyRCsNWIp6@wuerfel>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <2707354.mhmQEHxoKV@wuerfel>
 <CAGTfZH0VVT0hMn4ooRNZxnqjUQ_hF8nHg-4NtNriayick50qgw@mail.gmail.com>
 <13467157.nyRCsNWIp6@wuerfel>
Message-ID: <54F6AD6B.70007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2015 06:22 AM, Arnd Bergmann wrote:
> On Saturday 28 February 2015 09:47:01 Chanwoo Choi wrote:
>> "earlycon=exynos4210,0x14C20000" is correct bootparam. You can check
>> it on Documentation/kernel-parameters.txt as following.
>>
>>      exynos4210,<addr>
>>                 Use early console provided by serial driver available
>>                 on Samsung SoCs, requires selecting proper type and
>>                 a correct base address of the selected UART port. The
>>                 serial port must already be setup and configured.
>>                 Options are not yet supported.
>>
>>
> 
> But it's crazy to do this when you have a DT. Please fix the existing
> devicetree files that use this to just list 'earlycon'.
> 
> The syntax above only makes sense for classic board files that we
> do not support for exynos any more.

Following earlycon patch for exynos soc was merged in Linux 4.0-rc1.
- commit-id: b94ba0328d3b36ff95f5074c0e9b44f90dc56bb5 (serial: samsung: Add support for early console)
Almost Exynos SoC use the same UART IP of Exynos4210.

If you mean that "earlycon=exynos4210" naming will be changed to "earlycon=exynos",
we have to modify the drivers/tty/serial/samsung.c.

Thanks,
Chanwoo Choi
