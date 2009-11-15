From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 22:14:56 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <op.u3gddjdi2s3iss@ecaz> (Imre Kaloz's message of "Sun, 15 Nov
	2009 21:18:45 +0100")
References: <m3fx8fso72.fsf@intrepid.localdomain>
	<19200.18453.644399.845601@pilspetsen.it.uu.se>
	<op.u3gddjdi2s3iss@ecaz>
Message-ID: <m3y6m7qylr.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Imre Kaloz" <kaloz@openwrt.org> writes:

>> None. Having worked on the Synology DS101 support for mach-ixp4xx
>> I'm 99,99% certain that platform details can and should be private.
>>
>
> Or people can simply stop the #define brain damage and use the GPIO defines.
>
> (hint: IRQ_IXP4XX_GPIO* for PCI stuff, and the gpio number in
> i2c_gpio_platform_data)

I think it's not "or", it's orthogonal to the platforms' private
#defines issue.

Personally I use
#define xgpio_irq(n)            (IRQ_IXP4XX_GPIO ## n)
#define gpio_irq(n)             xgpio_irq(n)
I think we can switch to something similar on other platforms.
-- 
Krzysztof Halasa
