From: pmenzel+amd-gfx@molgen.mpg.de (Paul Menzel)
Date: Wed, 5 Sep 2018 13:02:32 +0200
Subject: [PATCH v3 03/13] fbdev: add kerneldoc do
 remove_conflicting_framebuffers()
In-Reply-To: <283fef19815b991700b56119d8d5874a2a8da44e.1535810304.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
 <283fef19815b991700b56119d8d5874a2a8da44e.1535810304.git.mirq-linux@rere.qmqm.pl>
Message-ID: <740483cb-2fbd-29ba-7f61-ed975ea5152f@molgen.mpg.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Micha?,


Thank you for documenting the function. Do you mean *to* instead of *do*
in the commit message summary?


On 09/01/18 16:08, Micha? Miros?aw wrote:
> Document remove_conflicting_framebuffers() behaviour.
> 
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/video/fbdev/core/fbmem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 0df148eb4699..2de93b5014e3 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1775,6 +1775,16 @@ int unlink_framebuffer(struct fb_info *fb_info)
>  }
>  EXPORT_SYMBOL(unlink_framebuffer);
>  
> +/**
> + * remove_conflicting_framebuffers - remove firmware-configured framebuffers
> + * @a: memory range, users of which are to be removed
> + * @name: requesting driver name
> + * @primary: also kick vga16fb if present
> + *
> + * This function removes framebuffer devices (initialized by firmware/bootloader)
> + * which use memory range described by @a. If @a is NULL all such devices are
> + * removed.
> + */
>  int remove_conflicting_framebuffers(struct apertures_struct *a,
>  				    const char *name, bool primary)
>  {

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/21f15c2d/attachment-0001.p7s>
