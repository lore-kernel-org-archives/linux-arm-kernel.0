From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 10 Apr 2013 11:27:59 +0300
Subject: [PATCH] video: mxsfb: Adapt to new videomode API
In-Reply-To: <1365516978-29888-1-git-send-email-fabio.estevam@freescale.com>
References: <1365516978-29888-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <5165228F.1020805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-04-09 17:16, Fabio Estevam wrote:
> commit 6cd2c7db4 (videomode: videomode_from_timing work) changed the name of 
> the function from videomode_from_timing() to videomode_from_timings().
> 
> commit 32ed6ef1 (videomode: create enum for videomode's display flags) changed
> the 'data_flags' field in videomode structure to 'flags'
> 
> Adapt to these changes in order to fix the following errors:
> 
> drivers/video/mxsfb.c:761:3: error: too many arguments to function 'videomode_from_timing'
> drivers/video/mxsfb.c:761:7: error: void value not ignored as it ought to be
> drivers/video/mxsfb.c:768:9: error: 'struct videomode' has no member named 'data_flags'
> drivers/video/mxsfb.c:770:9: error: 'struct videomode' has no member named 'data_flags'
> 
> Also select VIDEOMODE_HELPER in Kconfig to avoid linker errors.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

The mxsfb.c driver in my tree does not contain such code. Where is this
patch meant to be applied?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130410/3fb26f04/attachment.sig>
