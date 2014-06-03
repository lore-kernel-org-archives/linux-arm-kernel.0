From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Tue, 03 Jun 2014 08:02:37 +0200
Subject: [PATCH 2/3] arm: tegra: enable igb, stmpe, i2c chardev, spidev,
 lm95245, pwm leds
In-Reply-To: <20140602221627.GP31751@sirena.org.uk>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
 <538CA24B.1010602@wwwdotorg.org> <538CA635.4050502@ziswiler.com>
 <20140602221627.GP31751@sirena.org.uk>
Message-ID: <538D64FD.2010909@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2014 12:16 AM, Mark Brown wrote:
> On Mon, Jun 02, 2014 at 06:28:37PM +0200, Marcel Ziswiler wrote:
>> On 06/02/2014 06:11 PM, Stephen Warren wrote:
>
>>>> +CONFIG_SPI_SPIDEV=y
>
>>> Is this useful with DT? I thought that unlike I2C_CHARDEV, spidev needed
>>> dummy devices to exist in DT for spidev to work? If so, there's not much
>>> point adding the option to defconfig, since people can add it when they
>>> put the dummy devices into DT.
>
>> Yes, the Apalis T30 DT I sent actually contains two of them which we call
>> generic Apalis SPI1 and SPI2 out-of-the-box configured for exactly that.
>> Without the config enabled though it probably does not make much sense to
>> include it in the DT so I would consider removing it again.
>
> Your DT is broken if it's got a "spidev" node in it, you should be
> describing the hardware not the Linux implementation of the software.
> It would be really nice if we had a good way of handling this but we
> don't yet.

I strongly disagree, it almost perfectly describes the hardware. Unlike 
on I2c where modelling a bus is enough to allow generic user space 
access unfortunately on SPI this is not enough as it requires a specific 
chip-select as well. This is exactly what spidev does and maps to our 
hardware perfectly which has one dedicated chip-select per SPI bus on a 
dedicated header which allows our customers out-of-the-box spidev user 
space access to almost any SPI device connected to those buses just like 
with i2c-devs on I2C buses.
