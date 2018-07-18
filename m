From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 17:37:39 +0200
Subject: [PATCH net-next v2 3/7] net: mvneta: increase number of buffers
 in RX and TX queue
In-Reply-To: <20180713191720.GA17271@n2100.armlinux.org.uk> (Russell King's
 message of "Fri, 13 Jul 2018 20:17:20 +0100")
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
 <20180713161841.11202-4-gregory.clement@bootlin.com>
 <20180713191720.GA17271@n2100.armlinux.org.uk>
Message-ID: <87tvow8sho.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On ven., juil. 13 2018, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Fri, Jul 13, 2018 at 06:18:37PM +0200, Gregory CLEMENT wrote:
>> From: Yelena Krivosheev <yelena@marvell.com>
>> 
>> The initial values were too small leading to poor performance when using
>> the software buffer management.
>
> What does this do to latency when a large transfer is also ongoing
> (iow, the classic bufferbloat issue) ?

IXIA latency test had been done without seeing any differences for long
traffic (routing).

These new values offer better performance for the main usage of this SoC
(NAS applications), however both Rx and TX queues size can be change by
ethtool.

Gregory

>
>> 
>> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
>> [gregory: extract from a larger patch]
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  drivers/net/ethernet/marvell/mvneta.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
>> index f4e3943a745d..c22df28b07c8 100644
>> --- a/drivers/net/ethernet/marvell/mvneta.c
>> +++ b/drivers/net/ethernet/marvell/mvneta.c
>> @@ -295,10 +295,10 @@
>>  #define MVNETA_RSS_LU_TABLE_SIZE	1
>>  
>>  /* Max number of Rx descriptors */
>> -#define MVNETA_MAX_RXD 128
>> +#define MVNETA_MAX_RXD 512
>>  
>>  /* Max number of Tx descriptors */
>> -#define MVNETA_MAX_TXD 532
>> +#define MVNETA_MAX_TXD 1024
>>  
>>  /* Max number of allowed TCP segments for software TSO */
>>  #define MVNETA_MAX_TSO_SEGS 100
>> -- 
>> 2.18.0
>> 
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
> According to speedtest.net: 13Mbps down 490kbps up

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
