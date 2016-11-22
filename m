From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Nov 2016 16:49:01 +0100
Subject: [PATCH] drm/sun4i: Fix a return value in case of error
In-Reply-To: <20161118181847.8436-1-christophe.jaillet@wanadoo.fr>
References: <20161118181847.8436-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20161122154901.3bccughk6q6miu6w@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 07:18:47PM +0100, Christophe JAILLET wrote:
> If 'sun4i_backend_drm_format_to_layer()' does not return 0, then 'val' is
> left unmodified.
> As it is not initialized either, the return value can be anything.
> 
> It is likely that returning the error code was expected here.
> 
> As the only caller of 'sun4i_backend_update_layer_formats()' does not check
> the return value, this fix is purely theorical.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161122/a28ed215/attachment-0001.sig>
