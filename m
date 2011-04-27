From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Apr 2011 15:35:26 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <5BAE2D6F9E6047C19B6BE8FF26F7270B@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-2-git-send-email-subhasish@mistralsolutions.com>
	<4DB1A603.2090208@pengutronix.de>
	<EDC1056430EF4DA8A0D850CE1DEA28FC@subhasishg>
	<4DB7C5F7.3080103@pengutronix.de>
	<20110427091252.GP17290@n2100.arm.linux.org.uk>
	<5BAE2D6F9E6047C19B6BE8FF26F7270B@subhasishg>
Message-ID: <4DB81B9E.3000401@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 03:18 PM, Subhasish Ghosh wrote:
> My problem is, I am doing something like this:
> 
> s32 pruss_writel_multi(struct device *dev, u32 offset,
>                u32 *pdatatowrite, u16 wordstowrite)
> {
>        struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
>        u32 __iomem *paddresstowrite;
>        u16 i;
> 
>        paddresstowrite = pruss->ioaddr + offset;
> 
>        for (i = 0; i < wordstowrite; i++)
>                iowrite32(*pdatatowrite++, paddresstowrite++);
> 
>        return 0;
> }
> 
> So, if I make paddresstowrite as void, it will not work. The above
> implementation does not generate any sparse errors though.

Incrementing a u32 pointer will result in increasing the address by 4
bytes. Incrementing a void pointer will result in increasing the address
by just one byte. (Pointer arithmetic on void * is a gnu extension but
IMHO a pretty nice one, though)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110427/d0a11efa/attachment.sig>
