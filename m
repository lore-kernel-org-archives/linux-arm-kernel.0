From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 20 Sep 2018 12:04:58 -0500
Subject: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Message-ID: <46f95cf9-8f8f-e3ab-3142-947faeee9fa9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/20/2018 07:32 AM, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 

May be I missed smth, but it's acceptable to report standard error codes from
.xmit() callback as per dev_xmit_complete().

-- 
regards,
-grygorii
