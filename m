From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Jan 2015 12:55:47 -0600
Subject: [PATCHv3 1/2] USB: gadget: atmel_usba_udc: Fixed vbus_prev
 initial state
In-Reply-To: <54BD1028.20303@atmel.com>
References: <20150118175621.6b519cdc@bbrezillon>
 <1421601875-9436-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421601875-9436-2-git-send-email-sylvain.rochet@finsecur.com>
 <54BD1028.20303@atmel.com>
Message-ID: <20150119185547.GM20386@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 03:09:44PM +0100, Nicolas Ferre wrote:
> Le 18/01/2015 18:24, Sylvain Rochet a ?crit :
> > If vbus gpio is high at init, we should set vbus_prev to true
> > accordingly to the current vbus state. Without that, we skip the first
> > vbus interrupt because the saved vbus state is not consistent.
> > 
> > Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> 
> Indeed:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> We can also add the following tags:
> Fixes: 914a3f3b3754 ("USB: add atmel_usba_udc driver")
> Cc: <stable@vger.kernel.org> # 2.6.x-ish

Please resend with the proper stable format. Also, this 2.6.x-ish should
be 2.6.24+, git describe helps a lot figuring these out.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/d7afe913/attachment-0001.sig>
