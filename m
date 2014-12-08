From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 8 Dec 2014 14:53:39 +0100
Subject: [STLinux Kernel] [PATCH v3 0/4] spi: st: New driver for ST's
 SPI Controller
In-Reply-To: <11694915.sCOqLZA7N1@wuerfel>
References: <1418043214-14324-1-git-send-email-lee.jones@linaro.org>
 <11694915.sCOqLZA7N1@wuerfel>
Message-ID: <5485AD63.6090308@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/08/2014 02:22 PM, Arnd Bergmann wrote:
> On Monday 08 December 2014 12:53:30 Lee Jones wrote:
>> This is a new driver which controls the SPI component of ST's
>> Synchronous Serial Controller (SSC).
>>
> How does this related to the i2c driver for drivers/i2c/busses/i2c-st.c?
> Could you have the same piece of hardware do one or the other mode
> depending on pin configuration, or is each instance hardwired to
> a particular mode?
This is the same IP, that can be configured either in SPI or I2C.

>
> Is there any code worth sharing between the two drivers?
No, except a couple of registers, they are managed in a ways.

The way it is used, a single SSC instance can only be used either in SPI 
or I2C mode on a board,
so I think it wouldn't make sense to create a MFD driver to manage it.

Kr,
Maxime
>
> 	Arnd
>
> _______________________________________________
> Kernel mailing list
> Kernel at stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
