From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Jun 2013 15:31:50 +0100
Subject: [PATCH v2 1/3] mfd: Add irq domain support for max8998 interrupts
In-Reply-To: <1371818017-5215-2-git-send-email-t.figa@samsung.com>
References: <1371818017-5215-1-git-send-email-t.figa@samsung.com>
 <1371818017-5215-2-git-send-email-t.figa@samsung.com>
Message-ID: <20130621143150.GU27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 02:33:35PM +0200, Tomasz Figa wrote:

> The reverse mapping method used is linear mapping since the sub-drivers
> of max8998 such as regulator and charger drivers can use the max8998
> irq_domain to get the virtual irq number for max8998 interrupts.

> All uses of irq_base in platform data and max8997 driver private data
> are removed.

Can you use a simple IRQ domain in order to continue to support non-DT
systems (not all architectures use DT...)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/6c526209/attachment.sig>
