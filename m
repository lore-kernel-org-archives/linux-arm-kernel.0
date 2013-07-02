From: coelho@ti.com (Luciano Coelho)
Date: Tue, 2 Jul 2013 23:16:58 +0300
Subject: [PATCH v2 5/9] wlcore: always use one-shot IRQ
In-Reply-To: <20130702153229.GG7013@arwen.pp.htv.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-6-git-send-email-coelho@ti.com>
 <20130702153229.GG7013@arwen.pp.htv.fi>
Message-ID: <1372796218.21065.87.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-02 at 18:32 +0300, Felipe Balbi wrote:
> On Tue, Jul 02, 2013 at 05:55:44PM +0300, Luciano Coelho wrote:
> > Since we are now using threaded IRQs without the primary handler, we
> > need to set IRQF_ONESHOT, otherwise our request will fail.
> > 
> > Signed-off-by: Luciano Coelho <coelho@ti.com>
> 
> good to see this happening, I remember we talked about this a while back
> :-)

Yeah, we talked about it and I did the patch immediately.  This is
needed because this is obviously not set automatically in the interrupts
created via device tree.


> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Still, if you call irq_set_irq_type() on board-file (since DT will do
> something similar for you anyway) then you can completely drop
> irq_flags.

Yep.

--
Luca.
