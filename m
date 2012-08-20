From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Aug 2012 13:10:55 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120820083640.GH8450@gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
 <201208140942.54773.arnd@arndb.de>
 <CACRpkdYbOBEPNbCdfi+=gupdqS8_7t7MpOgXs7VCVTs8Y3j_mQ@mail.gmail.com>
 <20120820083640.GH8450@gmail.com>
Message-ID: <20120820121055.GA26991@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 09:36:43AM +0100, Lee Jones wrote:
> On Tue, Aug 14, 2012 at 12:44:37PM +0200, Linus Walleij wrote:

> > Yes but I think I saw this other patch set from Lee, hitting
> > irqdomain, OF and MFD to actually fix this ... or did I get
> > it wrong?

> No, you're not wrong.

> Historically (in my patches) xb8500_irq_get_virq() was used by drivers
> to obtain a VIRQ when not using Device Tree. Now the MFD core handles
> conversion there is little requirement for it. In fact there are no
> more users for db8500_irq_get_virq() and only one user for 
> ab8500_irq_get_virq() and that's itself. I guess we can rid them and
> call irq_get_mapping() directly instead.

Oh dear.  Unfortunately whoever added this support to the MFD core did
so in such a manner that it's only supported for device tree systems
and only for devices which express the MFD cells as device tree nodes
which means that most devices can't it - db8500 has got a reasonably
unusual combination there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120820/51e1c98f/attachment.sig>
