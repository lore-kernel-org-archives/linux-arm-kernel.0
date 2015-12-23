From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Dec 2015 12:00:19 +0000
Subject: [PATCH] regulator: mt6397: convert to arch_initcall
In-Reply-To: <1450865768-10317-1-git-send-email-henryc.chen@mediatek.com>
References: <1450865768-10317-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20151223120019.GU16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 06:16:08PM +0800, Henry Chen wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Due to some device may need reulator operation in earlier boot time like gpu module which
> power domain need regulator power on first. Move regulator of mt6397
> initialization earlier in boot so that real devices can use regulator
> without probe deferring.

Several problems here.  One is that we usually use subsys_initcall() for
working around the known broken subsystems here, why have you decided to
go for arch_initcall() instead.  Another is that you're saying this is
for GPUs but I'm not aware of any reason why GPUs are broken and we
should not be introducing new problems here - what's going on?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/3fc42bee/attachment.sig>
