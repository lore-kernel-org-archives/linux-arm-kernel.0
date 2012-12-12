From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 12 Dec 2012 09:49:47 +0100
Subject: linker problem with xip kernel and recent toolchains
In-Reply-To: <20121212084414.GF18999@sapphire.tkos.co.il>
References: <50BE0CDB.5000704@pengutronix.de>
 <1355230894.19818.1.camel@hornet> <50C7386E.70305@pengutronix.de>
 <1355249468.19818.23.camel@hornet> <50C83EB1.5050509@pengutronix.de>
 <20121212084414.GF18999@sapphire.tkos.co.il>
Message-ID: <50C8452B.4060205@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 09:44 AM, Baruch Siach wrote:
> Hi Marc,
> 
> On Wed, Dec 12, 2012 at 09:22:09AM +0100, Marc Kleine-Budde wrote:
>> On 12/11/2012 07:11 PM, Pawel Moll wrote:
>>> On Tue, 2012-12-11 at 13:43 +0000, Marc Kleine-Budde wrote:
>>>> What about putting the notes section into the read only segment, i.e.
>>>> the ROM?
>>>
>>> Could you, please, try the change below? It seems to do the job for me.
>>
>> Works for me. The kernel image links to 640 KiB again.
> 
> Thant's the lowest figure I've ever seen for a kernel image. How do you get 
> there?

It's for a nommu, armv7-m with thumb2 code. It doesn't have much
features, it lack /proc, /sys and even the networking subsystem. You can
find the .config in my previous mail [1].

Marc

[1] http://www.spinics.net/lists/arm-kernel/msg212007.html

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121212/97d8261d/attachment.sig>
