From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 2 Feb 2016 15:30:48 +0000
Subject: [PATCH 04/11] arm64: Introduce Allwinner SoC config option
In-Reply-To: <56B0C95B.4040500@gmail.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-5-git-send-email-andre.przywara@arm.com>
 <56B0C95B.4040500@gmail.com>
Message-ID: <56B0CBA8.3020804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/02/16 15:20, Matthias Brugger wrote:
> 
> 
> On 01/02/16 18:39, Andre Przywara wrote:
>> To prepare for the Allwinner A64 SoC support, introduce a config
>> option to allow compiling Allwinner (aka. sunxi) specific drivers
>> for the arm64 architecture as well.
>> This patch just defines the ARCH_SUNXI symbol to allow Allwinner
>> specific drivers to be selected during kernel configuration.
>> Since the MMC driver is quite essential for Linux to be useful, select
>> it by default.
>>
> 
> This mostly depends on the board you have. The rootfs could be on the
> flash, on nfs or even on a usb stick.

Yeah, could be. It's just that all boards I know of so far have either
SD card or eMMC.
Maybe it's better put in defconfig. I just want to avoid people getting
disappointed when enabling Allwinner support and not being able to use
it properly. You know that arm64 has only _one_ defconfig to rule them
all, so compiling a special kernel with magic config options is not the
usual drill for arm64 - for good reasons.

> I don't see why MMC support should be essential for A64 SoC.

So I guess I put it in defconfig then, together with the patch to
actually enable Allwinner support by default, which I forgot in this series.

Cheers,
Andre.
