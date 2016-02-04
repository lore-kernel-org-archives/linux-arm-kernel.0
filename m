From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 04 Feb 2016 10:36:10 +0300
Subject: [PATCH] KVM: arm/arm64: fix reference to uninitialised VGIC
In-Reply-To: <56B23A02.7070804@arm.com>
References: <1454518611-15694-1-git-send-email-andre.przywara@arm.com>
 <56B23A02.7070804@arm.com>
Message-ID: <009701d15f1e$b8398510$28ac8f30$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > Fix this by bailing out early of kvm_timer_flush_hwstate() if we don't
> > have a VGIC at all.
> >
> > Reported-by: Cosmin Gorgovan <cosmin@linux-geek.org>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Cc: <stable@vger.kernel.org> # 4.4.x
> 
> Nice catch, thanks.

 Can you check this: http://www.spinics.net/lists/kvm/msg124540.html ? It also should fix this issue. Just omit the very first hunk
from it, if you don't want to apply the whole set.


Kind regards,
Pavel Fedin
Senior Engineer
Samsung Electronics Research center Russia
