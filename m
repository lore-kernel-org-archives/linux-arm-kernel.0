From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 13 May 2014 15:36:21 +0200
Subject: [PATCHv3] C_CAN: hwinit support for non-TI devices
In-Reply-To: <20140513130914.GA9806@amd.pavel.ucw.cz>
References: <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120801.GA16461@amd.pavel.ucw.cz>
 <20140506135702.GA9879@amd.pavel.ucw.cz> <5370ED11.4000002@pengutronix.de>
 <20140513130914.GA9806@amd.pavel.ucw.cz>
Message-ID: <53721FD5.50508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 03:09 PM, Pavel Machek wrote:
> Non-TI chips (including socfpga) needs different raminit
> sequence. Implement it.
> 
> const's in the hwinit prototype forced me to add const to more
> prototypes. This makes changes bigger but the result is cleaner.

Why not split into several patches?

> Unfortunately, testing-c_can does not boot on sockit, but previous
> version of patch was tested by me and Thor Thayer.

Have a look at:

    git at gitorious.org:linux-can/linux-can-next.git
testing-c_can-based-on-net

This branch uses net/master as it's base, I've split your patch into 3,
and squashed the 32bit-const changes into the 32-bit access patch. The
remaining patch looks quite clean.

Can you please test the branch, I hope it boots on sockit.

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
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/cdda9e7a/attachment.sig>
