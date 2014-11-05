From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 05 Nov 2014 11:41:34 +0100
Subject: [PATCH V1 4/4] can: m_can: allow to send std frame on CAN FD mode
In-Reply-To: <1415174326-6623-4-git-send-email-b29396@freescale.com>
References: <1415174326-6623-1-git-send-email-b29396@freescale.com>
 <1415174326-6623-4-git-send-email-b29396@freescale.com>
Message-ID: <5459FEDE.9050405@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2014 08:58 AM, Dong Aisheng wrote:
> The current code sends all CAN frames on CAN FD format(with BRS or not)
> if CAN_CTRLMODE_FD is enabled.
> However, even CAN_CTRLMODE_FD is enabled, the can tool may still
> send normal frames.
> e.g.
> ip link set can0 up type can bitrate 1000000 dbitrate 1000000 fd on
> cansend can0 123#112233
> 
> Therefore sending normal CAN frame on FD format seems not reasonable
> and the CAN FD incapable device may not be able to receive it correctly.
> 
> The patch switches the M_CAN operation mode to ISO11898-1 instead of
> staying on CAN FD operation mode by writing "11" to CMR bit if find
> we're sending a normal can skb.

With this patch applied and Olivre's version of 3/4, how does the
application send CAN-FD frames?
1. witch on CAN-FD via "ip fd on"
2. write a struct canfd_frame

Correct?

What happens if:
3. write a struct can_frame

A CAN frame is send?

Oliver are you okay with this behaviour?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/1a6e3879/attachment-0001.sig>
