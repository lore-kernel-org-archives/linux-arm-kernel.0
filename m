From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 09 Nov 2011 20:31:53 +0100
Subject: [PATCH v3] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <CAOMZO5Af9XCB8OGGJo0Hb-Bhhv_R==cS-D3jeC-NKvzbANbMyw@mail.gmail.com>
References: <1320401551-21377-1-git-send-email-b39297@freescale.com>	<4EBAA038.6010606@pengutronix.de>
 <CAOMZO5Af9XCB8OGGJo0Hb-Bhhv_R==cS-D3jeC-NKvzbANbMyw@mail.gmail.com>
Message-ID: <4EBAD529.1010608@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2011 05:51 PM, Fabio Estevam wrote:
> On Wed, Nov 9, 2011 at 1:46 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>> +static int mc9s08dz60_remove(struct i2c_client *client)
>>> +{
>>> +     struct mc9s08dz60 *mc9s;
>>> +     int ret;
>>> +
>>> +     mc9s = i2c_get_clientdata(client);
>>> +
>>> +     i2c_set_clientdata(client, NULL);
>>> +
>>> +     ret = gpiochip_remove(&mc9s->chip);
>>> +     if (!ret)
>>> +             kfree(mc9s);
>>> +
>>> +     return 0;
>>
>> return 0 if gpiochip_remove() fails?
> 
> See Russell's comment about returning error on this remove function:
> http://www.spinics.net/lists/arm-kernel/msg146501.html

tnx for the hint - I must have missed that comment.

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111109/76e79ff8/attachment.sig>
