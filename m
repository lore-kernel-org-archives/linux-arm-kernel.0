From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 01 Mar 2015 22:22 +0100
Subject: [PATCH v4 2/8] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <CAGTfZH0VVT0hMn4ooRNZxnqjUQ_hF8nHg-4NtNriayick50qgw@mail.gmail.com>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <2707354.mhmQEHxoKV@wuerfel>
 <CAGTfZH0VVT0hMn4ooRNZxnqjUQ_hF8nHg-4NtNriayick50qgw@mail.gmail.com>
Message-ID: <13467157.nyRCsNWIp6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 February 2015 09:47:01 Chanwoo Choi wrote:
> "earlycon=exynos4210,0x14C20000" is correct bootparam. You can check
> it on Documentation/kernel-parameters.txt as following.
> 
>      exynos4210,<addr>
>                 Use early console provided by serial driver available
>                 on Samsung SoCs, requires selecting proper type and
>                 a correct base address of the selected UART port. The
>                 serial port must already be setup and configured.
>                 Options are not yet supported.
> 
> 

But it's crazy to do this when you have a DT. Please fix the existing
devicetree files that use this to just list 'earlycon'.

The syntax above only makes sense for classic board files that we
do not support for exynos any more.

	Arnd
