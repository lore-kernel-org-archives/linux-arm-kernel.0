From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Jul 2013 18:32:29 +0300
Subject: [PATCH v2 5/9] wlcore: always use one-shot IRQ
In-Reply-To: <1372776948-24840-6-git-send-email-coelho@ti.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-6-git-send-email-coelho@ti.com>
Message-ID: <20130702153229.GG7013@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 05:55:44PM +0300, Luciano Coelho wrote:
> Since we are now using threaded IRQs without the primary handler, we
> need to set IRQF_ONESHOT, otherwise our request will fail.
> 
> Signed-off-by: Luciano Coelho <coelho@ti.com>

good to see this happening, I remember we talked about this a while back
:-)

Acked-by: Felipe Balbi <balbi@ti.com>

Still, if you call irq_set_irq_type() on board-file (since DT will do
something similar for you anyway) then you can completely drop
irq_flags.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/d9741fff/attachment-0001.sig>
