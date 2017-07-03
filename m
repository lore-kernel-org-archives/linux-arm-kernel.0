From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Jul 2017 23:29:43 +0200
Subject: [PATCH] drm/sun4i : constify drm_plane_helper_funcs
In-Reply-To: <bcf0c7481aa8bc4731ea3fc7e71815fbb7703681.1499097717.git.arvind.yadav.cs@gmail.com>
References: <bcf0c7481aa8bc4731ea3fc7e71815fbb7703681.1499097717.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170703212943.g2i2c2x5w5jwva4c@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 03, 2017 at 09:35:20PM +0530, Arvind Yadav wrote:
> drm_plane_helper_funcs are not supposed to change at runtime.
> All functions working with drm_plane_helper_funcs provided by
> <drm/drm_plane_helper.h> work with const drm_plane_helper_funcs.
> So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>     981	     40	      0	   1021	    3fd drivers/gpu/drm/sun4i/sun4i_layer.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    1021	      0	      0	   1021	    3fd drivers/gpu/drm/sun4i/sun4i_layer.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Queued for 4.14, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170703/0d3cc400/attachment.sig>
