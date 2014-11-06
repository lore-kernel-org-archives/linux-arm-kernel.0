From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 06 Nov 2014 13:47:20 +0100
Subject: M_CAN message RAM initialization AppNote  - was: Re: [PATCH V3
 3/3] can: m_can: workaround for transmit data less than 4 bytes
In-Reply-To: <545B6AB4.70003@hartkopp.net>
References: <1415193393-30023-1-git-send-email-b29396@freescale.com>
 <1415193393-30023-3-git-send-email-b29396@freescale.com>
 <545A3451.2090302@pengutronix.de> <545A692E.40002@hartkopp.net>
 <20141106015716.GB7642@shlinux1.ap.freescale.net>
 <545B1D71.4000408@hartkopp.net>
 <20141106080940.GA22964@shlinux1.ap.freescale.net>
 <545B6AB4.70003@hartkopp.net>
Message-ID: <545B6DD8.6010906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2014 01:33 PM, Oliver Hartkopp wrote:
>> So i'm not sure memset() the entire TX FIFO element is neccesary...
> 
> It's no big deal - so we should be defensive here.
> And memset() is not working as Marc pointed out in another mail.
> 
> So we would need to loop with
> 
>     m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i), 0x0);
> 
>>
>> Do you think we could keep the current solution firstly and updated later
>> if needed?
> 
> No :-)
> 
> I would like to have all data bytes to be written at startup.

Me, too. As this happens only once during ifconfig up it should not hurt
performance, either send an incremental or new patch. I'll sort it out.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/87580684/attachment.sig>
