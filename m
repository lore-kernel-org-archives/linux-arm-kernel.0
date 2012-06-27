From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 14:02:57 +0200
Subject: [PATCH v7 08/14] USB: Chipidea: add ci13xxx device id management
In-Reply-To: <201206271349.45641.marex@denx.de>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <4FE83AA9.6030507@pengutronix.de>
 <20120627054231.GA21750@b20223-02.ap.freescale.net>
 <201206271349.45641.marex@denx.de>
Message-ID: <4FEAF671.80508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2012 01:49 PM, Marek Vasut wrote:
> Dear Richard Zhao,
> 
>> On Mon, Jun 25, 2012 at 12:17:13PM +0200, Marc Kleine-Budde wrote:
>>> On 06/25/2012 12:03 PM, Richard Zhao wrote:
>>>> Could you use my USB test branch?
>>>
>>> Same result:
>>>
>>> ci_hdrc ci_hdrc.0: remove, state 1
>>> usb usb1: USB disconnect, device number 1
>>> ci_hdrc ci_hdrc.0: USB bus 1 deregistered
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 0000006c pgd = c6ba4000
>>> [0000006c] *pgd=46a68831, *pte=00000000, *ppte=00000000
>>> Internal error: Oops: 17 [#1] PREEMPT ARM
>>> Modules linked in: ci13xxx_imx(-) ci_hdrc imx_usbmisc
>>> CPU: 0    Not tainted  (3.5.0-rc4-00058-g01710ef #85)
> 
> Dumb question -- you use the same base revision of kernel, right?

Yes, I used v3.5-rc4 as baseline, add some mx28 specific patches (nand,
etc...), then I merged in Richard's use tree. In the above oops, as the
asked, the USB test branch.

In original oops I used
https://github.com/riczhao/kernel-imx/commits/topics/usb-driver

Maybe it's some other part of the system that confuses the ida_* stuff.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/9bbf9825/attachment.sig>
