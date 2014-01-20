From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 20 Jan 2014 13:21:47 +0200
Subject: [PATCH 13/15] fbdev: sh-mobile-lcdcfb: Enable driver compilation
 with COMPILE_TEST
In-Reply-To: <22423852.GiH1NBjiii@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <52CD0CBB.3070801@ti.com> <52D8F14A.7030100@ti.com>
 <22423852.GiH1NBjiii@avalon>
Message-ID: <52DD06CB.8050606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-19 23:01, Laurent Pinchart wrote:
> Hi Tomi,

> The lcdc driver can be compiled without meram support. This is handled by 
> conditional compilation in include/video/sh_mobile_meram.h that defines the 
> meram functions as stubs when meram support isn't selected.
> 
> The problem comes from the combination of FB_SH_MOBILE_MERAM=m and 
> FB_SH_MOBILE_LCDC=y. The former makes the meram function non-stubs, while the 
> later makes the LCDC driver fail to link, as meram support is then compiled as 
> a module.
> 
> How do you usually handle this ?

I guess the easiest option is to make FB_SH_MOBILE_MERAM a bool, instead
of tristate.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/6d5866fc/attachment.sig>
