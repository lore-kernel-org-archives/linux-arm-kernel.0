From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jun 2015 20:12:11 +0100
Subject: [PATCH 02/15] regmap: kill off set_irq_flags usage
In-Reply-To: <1433874401-27161-3-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-3-git-send-email-robh@kernel.org>
Message-ID: <20150609191211.GA14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 01:26:28PM -0500, Rob Herring wrote:

> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.

Well, I don't think it's blind - IIRC it's just that this code all
predates the genirq flags and ARM had the opposite default to x86 (I
guess because of being conservative about all the random interrupt
controllers you get and what might be hanging off them) so we needed to
do this dance to get interrupts to work.

Anyway, I've applied this - thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/07a9ae89/attachment.sig>
