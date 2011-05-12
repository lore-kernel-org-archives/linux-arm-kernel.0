From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 12 May 2011 15:04:50 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <201105121454.47781.arnd@arndb.de>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<201105112344.44171.arnd@arndb.de>
	<4DCB88A4.2010901@grandegger.com>
	<201105121454.47781.arnd@arndb.de>
Message-ID: <4DCBDAF2.7040101@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2011 02:54 PM, Arnd Bergmann wrote:
> On Thursday 12 May 2011, Wolfgang Grandegger wrote:
>> Well, that seems sophisticated resulting in a complex implementation
>> (may code line) also because hardware filters are very hardware
>> dependent. Usually just one global filter can be defined. I think that's
>> overkill. A simple interface using:
>>
>>   ip link set can0 type can filter <id>:<mask> [<id>:<mask> ...]
>>
>> would just be fine.
> 
> Ok, fair enough. Still I would suggest you first come up with
> a reasonable user interface (the one you posted may be just right,
> I don't know), and then let someone do the implementation in the
> pruss firmware that is the best match for the user interface, rather
> than the other way around.

I suggested some time ago to implement the more-or-less standard
<id>:<mask> filter instead of just a single <id> (per filter entry). The
cost is probably quite low, it's just a single AND operation per filter
entry more expensive.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110512/be9eb351/attachment.sig>
