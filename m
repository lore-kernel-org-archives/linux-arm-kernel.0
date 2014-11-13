From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 13 Nov 2014 13:03:22 +0100
Subject: [PATCH] can: Fix bug in suspend/resume
In-Reply-To: <20141113123218.79850236@ipc1.ka-ro>
References: <a44efc1fb0144cca9d0c4851cc51db25@BL2FFO11FD024.protection.gbl>	<546484D9.4030005@pengutronix.de>	<54648BF4.60007@pengutronix.de>	<9455da2b86c74d5aafe9bf118edec7bb@BN1AFFO11FD045.protection.gbl>
 <20141113123218.79850236@ipc1.ka-ro>
Message-ID: <54649E0A.7030607@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2014 12:32 PM, Lothar Wa?mann wrote:
>>>>  static int __maybe_unused xcan_suspend(struct device *dev)  {
>>>> -    struct platform_device *pdev = dev_get_drvdata(dev);
>>>> +    struct platform_device *pdev = container_of(dev,
>>>> +                    struct platform_device, dev);
>>>>      struct net_device *ndev = platform_get_drvdata(pdev);
>>>>      struct xcan_priv *priv = netdev_priv(ndev);
>>
> Why not simply:
> 	struct net_device *ndev = dev_get_drvdata(dev);
> 
> There is no need for a struct platform_device* at all.

ACK

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/7020cd38/attachment.sig>
