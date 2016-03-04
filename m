From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 4 Mar 2016 09:05:42 -0700
Subject: [PATCH net-next V2 08/16] net: fec: eliminate calls to
 fec_enet_get_prevdesc
In-Reply-To: <VI1PR0401MB18556C9393B8629330062B8EFFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-9-git-send-email-troy.kisky@boundarydevices.com>
 <VI1PR0401MB18556C9393B8629330062B8EFFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
Message-ID: <56D9B256.7040408@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/4/2016 2:33 AM, Fugang Duan wrote:
> From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Thursday, February 25, 2016 8:37 AM
>> To: netdev at vger.kernel.org; davem at davemloft.net; b38611 at freescale.com
>> Cc: fabio.estevam at freescale.com; l.stach at pengutronix.de; andrew at lunn.ch;
>> tremyfr at gmail.com; linux at arm.linux.org.uk; linux-arm-
>> kernel at lists.infradead.org; laci at boundarydevices.com; shawnguo at kernel.org;
>> johannes at sipsolutions.net; stillcompiling at gmail.com;
>> sergei.shtylyov at cogentembedded.com; arnd at arndb.de; Troy Kisky
>> <troy.kisky@boundarydevices.com>
>> Subject: [PATCH net-next V2 08/16] net: fec: eliminate calls to
>> fec_enet_get_prevdesc
>>
>> This shrinks the code a little.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>> ---
>>  drivers/net/ethernet/freescale/fec_main.c | 37 +++++++++----------------------
>>  1 file changed, 11 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c
>> index 6ceb5f9..b5ed287 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -758,6 +758,7 @@ static void fec_enet_bd_init(struct net_device *dev)
>>  	struct bufdesc *bdp;
>>  	unsigned int i;
>>  	unsigned int q;
>> +	unsigned status;
> 
> Should be unsigned int status;
> 


Fine



Thanks
