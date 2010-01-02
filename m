From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2010 11:45:35 +0000
Subject: [PATCH 3/7] [ARM] locomo: remove unused IRQs and avoid
	unnecessary cascade
In-Reply-To: <1261977488-18271-4-git-send-email-eric.y.miao@gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
	<1261977488-18271-4-git-send-email-eric.y.miao@gmail.com>
Message-ID: <20100102114535.GD2529@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 01:18:04PM +0800, Eric Miao wrote:
> IRQ_LOCOMO_* are never used elsewhere, remove these definitions. As well
> as the cascade of these IRQs. IRQ_LOCOMO_*_BASE changed to IRQ_LOCOMO_*.

I think the removal of the KEY stuff should be part of the previous
patch; the removal of the keyboard interrupt indirection as a whole
forms one logical and self-contained change.

The removal of the other unnecessary indirections should probably
live as a separate patch.
