From: kaloz@openwrt.org (Imre Kaloz)
Date: Tue, 17 Nov 2009 22:37:13 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <m3y6m7qylr.fsf@intrepid.localdomain>
References: <m3fx8fso72.fsf@intrepid.localdomain>
	<19200.18453.644399.845601@pilspetsen.it.uu.se>
	<op.u3gddjdi2s3iss@ecaz> <m3y6m7qylr.fsf@intrepid.localdomain>
Message-ID: <op.u3j6cak02s3iss@richese>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2009.11.15. 22:14:56 Krzysztof Halasa <khc@pm.waw.pl> wrote:

> "Imre Kaloz" <kaloz@openwrt.org> writes:
>
>>> None. Having worked on the Synology DS101 support for mach-ixp4xx
>>> I'm 99,99% certain that platform details can and should be private.
>>>
>>
>> Or people can simply stop the #define brain damage and use the GPIO defines.
>>
>> (hint: IRQ_IXP4XX_GPIO* for PCI stuff, and the gpio number in
>> i2c_gpio_platform_data)
>
> I think it's not "or", it's orthogonal to the platforms' private
> #defines issue.
>
> Personally I use
> #define xgpio_irq(n)            (IRQ_IXP4XX_GPIO ## n)
> #define gpio_irq(n)             xgpio_irq(n)
> I think we can switch to something similar on other platforms.

Ok, I should be completely missing the point here, but could someone enlighten
me why would the following make sense? (nslu2 example)

#define NSLU2_PCI_INTA_PIN	11
#define NSLU2_PCI_INTB_PIN	10
#define NSLU2_PCI_INTC_PIN	9
#define NSLU2_PCI_INTD_PIN	8

#define        IRQ_NSLU2_PCI_INTA      IRQ_IXP4XX_GPIO11
#define        IRQ_NSLU2_PCI_INTB      IRQ_IXP4XX_GPIO10
#define        IRQ_NSLU2_PCI_INTC      IRQ_IXP4XX_GPIO9

Then do all the "fun" in the setup code, instead of simply using
The already defined (and hardware wise more logical) IRQ_IXP4XX_GPIOx values like
I do in arch/arch/mach-ixp4xx/wg302v2-pci.c for example?


Imre
