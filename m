From: alan@linux.intel.com (Alan Cox)
Date: Tue, 21 Aug 2012 12:50:05 +0100
Subject: [RFC/PATCH 02/13] serial: omap: always return IRQ_HANDLED
In-Reply-To: <1345540555-24359-3-git-send-email-balbi@ti.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345540555-24359-3-git-send-email-balbi@ti.com>
Message-ID: <20120821125005.235926e0@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Aug 2012 12:15:44 +0300
Felipe Balbi <balbi@ti.com> wrote:

> Even if we enter our IRQ handler just to notice
> that the our device didn't generate the IRQ,
> that still means "handling" and IRQ, so let's
> return IRQ_HANDLED.

That looks wrong - you'll defeat the stuck IRQ protection. If we didn't
cause the IRQ then we are IRQ_NONE ?
