From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 28 May 2010 15:45:18 +0200
Subject: [PATCH 4/4] mx35: add flexcan devices
In-Reply-To: <20100528133424.GA2001@bluebox.local>
References: <1275046938-8465-1-git-send-email-mkl@pengutronix.de>
	<1275046938-8465-5-git-send-email-mkl@pengutronix.de>
	<20100528133424.GA2001@bluebox.local>
Message-ID: <4BFFC8EE.8060501@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hans J. Koch wrote:
> On Fri, May 28, 2010 at 01:42:18PM +0200, Marc Kleine-Budde wrote:
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  arch/arm/mach-mx3/devices.c |   40 ++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-mx3/devices.h |    2 ++
>>  2 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
>> index db7acd6..0e1e20b 100644
>> --- a/arch/arm/mach-mx3/devices.c
>> +++ b/arch/arm/mach-mx3/devices.c
>> @@ -127,6 +127,46 @@ struct platform_device mxc_uart_device4 = {
>>  };
>>  #endif /* CONFIG_ARCH_MX31 */
>>  
>> +#ifdef CONFIG_ARCH_MX35
>> +static struct resource mxc_can_1_resources[] = {
>> +	{
>> +		.start	= 0x53fe4000,
>> +		.end	= 0x53fe7fff,
>> +		.flags	= IORESOURCE_MEM,
>> +	}, {
>> +		.start	= 43,
>> +		.end	= 43,
>> +		.flags	= IORESOURCE_IRQ,
>> +	}
>> +};
>> +
>> +struct platform_device mxc_can_device0 = {
>> +	.name = "flexcan",
> 
> Did you also post the flexcan driver itself somewhere? I've got such a device
> on my desk right now, and would be willing to test that. I've made some tests
> with Sascha's old version, but it's not really satisfying...

It's not yet posted, I'm currently restructuring the driver with regards
to the set_bittiming and control mode discussion on the socketcan ML.

cheers, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100528/a45970b7/attachment.sig>
