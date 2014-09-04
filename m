From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Thu, 4 Sep 2014 09:11:10 +0000
Subject: [Patch net-next 08/11] net:fec: change FEC alignment to 64 bytes
 for ARM platform
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17487196@AcuExch.aculab.com>
References: <1409776697-1536-1-git-send-email-Frank.Li@freescale.com>
 <1409776697-1536-9-git-send-email-Frank.Li@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D17487196@AcuExch.aculab.com>
Message-ID: <e50c6383dc184566846e190026d1186a@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Laight <David.Laight@ACULAB.COM> Sent: Thursday, September 04, 2014 4:51 PM
>To: Li Frank-B20596; Duan Fugang-B38611; davem at davemloft.net;
>netdev at vger.kernel.org; lznuaa at gmail.com
>Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org;
>devicetree at vger.kernel.org; Duan Fugang-B38611
>Subject: RE: [Patch net-next 08/11] net:fec: change FEC alignment to 64
>bytes for ARM platform
>
>From: Frank Li
>> From: Fugang Duan <B38611@freescale.com>
>>
>> Since enet-avb has 64 bytes alignment limitation for rx DMA transfer.
>> The previous enet IP for ARM platform has 16 bytes alignment for tx
>> DMA transfer.
>
>Do you mean rx or tx here? or both??
>
>And can we beat up the hardware designers to stop these restrictions on rx
>(in particular) ethernet buffer alignments?
>A device isn't suitable for ethernet unless is can write the destination
>mac address to a 4n+2 boundary.
>
>	David
>
Hi, David,

For previous enet IP there has 16 bytes data buffer alignment limitation for tx & rx DMA transfer.
For imx6sx enet-avb IP, there has 64 bytes data buffer alignment limitation for rx DMA transfer, byte alignment for tx data
Buffer for DMA transfer.

I think rx data buffer alignment limitation don't introduce performance drop, is not complex for sw implemention. Anyway,
We can request IC designer to remove the limitation for future chips.

Thanks,
Andy

>> 64 is the an integral number of 16, so change alignment to 64 bytes
>> for all ARM platform, which don't impact the performance of previous
>> platform.
>>
>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>> ---
>>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c
>> index a232245..b388e29f 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -65,7 +65,7 @@
>>  static void set_multicast_list(struct net_device *ndev);
>>
>>  #if defined(CONFIG_ARM)
>> -#define FEC_ALIGNMENT	0xf
>> +#define FEC_ALIGNMENT	0x3f
>>  #else
>>  #define FEC_ALIGNMENT	0x3
>>  #endif
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>> the body of a message to majordomo at vger.kernel.org More majordomo info
>> at  http://vger.kernel.org/majordomo-info.html
