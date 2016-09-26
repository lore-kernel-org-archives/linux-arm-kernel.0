From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Sep 2016 11:13:37 -0300
Subject: [PATCH] serial: imx: Fix DCD reading
In-Reply-To: <20160926140938.ikjatvprk3t4lsed@pengutronix.de>
References: <20160926135531.31888-1-s.hauer@pengutronix.de>
 <20160926140938.ikjatvprk3t4lsed@pengutronix.de>
Message-ID: <CAOMZO5Aw8pkt_tnM=M0SewN-Xjqq84E-mef-ewGs8aTv0xcHjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2016 at 11:09 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hallo,
>
> On Mon, Sep 26, 2016 at 03:55:31PM +0200, Sascha Hauer wrote:
>> The USR2_DCDIN bit is tested for in register usr1. As the name
>> suggests the usr2 register should be used instead. This fixes
>> reading the Carrier detect status.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Fixes: 90ebc4838666 ("serial: imx: repair and complete handshaking")
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Great, so it affects 4.5+ kernels and should probably have:

Cc: <stable@vger.kernel.org> # 4.5+
