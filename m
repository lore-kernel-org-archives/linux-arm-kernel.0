From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 12 May 2011 00:39:55 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <201105112344.44171.arnd@arndb.de>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<2BFFDAA0A0DE4820876E5549867938EC@subhasishg>
	<201105112331.47954.arnd@arndb.de>
	<201105112344.44171.arnd@arndb.de>
Message-ID: <4DCB103B.30801@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2011 11:44 PM, Arnd Bergmann wrote:
> On Wednesday 11 May 2011, Arnd Bergmann wrote:
>> If that interpretation is right, I would seriously recommend rethinking
>> the design of the CAN firmware for pruss, so you can start doing something
>> useful with the offload engine that fits into the Socket CAN API, or that
>> would be a useful extension to Socket CAN that is also implementable in
>> the kernel for all other drivers in a meaningful way.
> 
> I've looked some more into the CAN socket implementation, and I suppose that
> the idea of the pruss driver was really to help do the work from the
> can_rcv_filter function in hardware.
> 
> Doing this right would really mean supporting both a mode where any new
> filter that gets added to socket can ends up being added to the hardware
> as long as it fits, similar to how we can add additional unicast mac
> addresses to an ethernet NIC. However, when the filters from all user
> sockets combined can not be represented in the hardware driver, the hardware
> needs to be put into a less efficient mode where all packets are returned
> to the kernel and processed in software.

I'm not sure if reprogramming hardware filters on the fly works on evey
can core. The more conservative solution would be to configure the
filter list globally (+when the interface is down) via netlink.

regards, Marc

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110512/d1257aeb/attachment.sig>
