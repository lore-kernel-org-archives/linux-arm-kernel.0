From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 9 Nov 2016 09:50:37 +0100
Subject: [PATCH] arm64: dts: marvell: add unique identifiers for Armada
 A8k SPI controllers
In-Reply-To: <8737j1m44b.fsf@free-electrons.com>
References: <1478622692-18441-1-git-send-email-mw@semihalf.com>
 <20161108174851.2cd8efb4@free-electrons.com>
 <8737j1m44b.fsf@free-electrons.com>
Message-ID: <CAPv3WKeTqzQ9YbX7YmbJGNqD_4BrM6oUNCAN+RCaM5d9X8tbYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks a lot!

Marcin

2016-11-09 9:47 GMT+01:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Hi Marcin,
>
>  On mar., nov. 08 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>
>> Hello,
>>
>> On Tue,  8 Nov 2016 17:31:32 +0100, Marcin Wojtas wrote:
>>> Enabling SPI controllers, which are attached to different busses
>>> inside an SoC, may result in overlapping enumeration and cause
>>> sysfs registration failure. Example log after enabling two
>>> controllers on Armada 8040 SoC with same identifiers:
>>>
>>> [    3.740415] sysfs: cannot create duplicate filename
>>> '/class/spi_master/spi0'
>>> [    3.747510] ------------[ cut here ]------------
>>> [    3.752145] WARNING: at fs/sysfs/dir.c:31
>>> [...]
>>> [    4.002299] orion_spi: probe of f4700600.spi failed with error -17
>>>
>>> spi-orion driver offers dedicated DT property ('cell-index'), that
>>> allow setting unique identifiers. Recently added support for CP110-slave
>>> HW block introduced two new SPI controllers' nodes with same ID as
>>> ones from CP110-master.
>>>
>>> This commit fixes the issue by assigning different 'cell-index' values
>>> for CP110-slave SPI controllers.
>>>
>>> Fixes: 4eef78a0091b ("arm64: dts: marvell: add description for the slave
>>> CP110 in Armada 8K")
>>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>>
>> It's sad that we need to hardcode those indexes in the Device Tree
>> (which by no means are a description of the HW by the way), but that's
>> what the SPI framework expects I believe. Therefore:
>>
>> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
>
> Applied on mvebu/fixes with acked-by from Thomas.
> In the same time I also applied "arm64: dts: marvell: fix clocksource
> for CP110 slave SPI0" which didn't find his way to mainline yet.
>
> Thanks,
>
> Gregory
>
>
>>
>> Thomas
>> --
>> Thomas Petazzoni, CTO, Free Electrons
>> Embedded Linux and Kernel engineering
>> http://free-electrons.com
>
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
