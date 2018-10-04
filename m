From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 4 Oct 2018 21:54:06 +0200
Subject: [PATCH v2 1/2] drm/sun4i: tcon: fix check of tcon->panel null
 pointer
In-Reply-To: <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
 <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
Message-ID: <20181004195406.prjuko556tnuau2u@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 03, 2018 at 04:24:57PM +0200, Giulio Benetti wrote:
> At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
> has been used, but that macro doesn't check if tcon->panel pointer is
> null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).
> 
> Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
> condition to check if it's a pointer not null.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

The commit log should be improved. The issue isn't really with the
IS_ERR macro as you suggest, but that what is returned by
of_drm_find_panel, and thus stored in tcon->panel. is not an error
pointer in the first place but a NULL pointer on error. So the check
doesn't check for the proper thing.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181004/5728b4a0/attachment.sig>
