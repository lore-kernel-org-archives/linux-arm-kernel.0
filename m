From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 4 Mar 2016 09:05:12 -0700
Subject: [PATCH net-next V2 13/16] net: fec: print more debug info in
 fec_timeout
In-Reply-To: <VI1PR0401MB18552AB3E4128E412273B439FFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-14-git-send-email-troy.kisky@boundarydevices.com>
 <VI1PR0401MB18552AB3E4128E412273B439FFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
Message-ID: <56D9B238.2040400@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/4/2016 3:06 AM, Fugang Duan wrote:
> From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Thursday, February 25, 2016 8:37 AM
>> To: netdev at vger.kernel.org; davem at davemloft.net; b38611 at freescale.com
>> Cc: fabio.estevam at freescale.com; l.stach at pengutronix.de; andrew at lunn.ch;
>> tremyfr at gmail.com; linux at arm.linux.org.uk; linux-arm-
>> kernel at lists.infradead.org; laci at boundarydevices.com; shawnguo at kernel.org;
>> johannes at sipsolutions.net; stillcompiling at gmail.com;
>> sergei.shtylyov at cogentembedded.com; arnd at arndb.de; Troy Kisky
>> <troy.kisky@boundarydevices.com>
>> Subject: [PATCH net-next V2 13/16] net: fec: print more debug info in
>> fec_timeout
>>
>> Print the current interrupt flags and mask and the interrupt state during the last
>> interrupt in fec_timeout.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>> ---
>>  drivers/net/ethernet/freescale/fec.h      | 1 +
>>  drivers/net/ethernet/freescale/fec_main.c | 4 ++++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec.h
>> b/drivers/net/ethernet/freescale/fec.h
>> index 001200b..615cca1 100644
>> --- a/drivers/net/ethernet/freescale/fec.h
>> +++ b/drivers/net/ethernet/freescale/fec.h
>> @@ -506,6 +506,7 @@ struct fec_enet_private {
>>  	unsigned int total_tx_ring_size;
>>  	unsigned int total_rx_ring_size;
>>  	uint	events;
>> +	uint	last_ievents;
>>
>>  	struct	platform_device *pdev;
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c
>> index afd4060..9a3136b 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -1107,6 +1107,9 @@ fec_timeout(struct net_device *ndev)
>>  	int i;
>>  	uint events = 0;
>>
>> +	pr_err("%s: last=%x %x, mask %x\n", __func__, fep->last_ievents,
>> +	       readl(fep->hwp + FEC_IEVENT), readl(fep->hwp + FEC_IMASK));
>> +
> pr_err() -> netdev_err()
> 


Sounds good
