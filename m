From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 22 Jun 2013 12:54:25 +0200
Subject: [PATCH] drm: always provide debugfs function prototypes
In-Reply-To: <201306220038.17115.arnd@arndb.de>
References: <201306220038.17115.arnd@arndb.de>
Message-ID: <20130622105424.GA16861@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 12:38:16AM +0200, Arnd Bergmann wrote:
> It is generally considered bad style to enclose function prototypes
> in header files in #ifdef. This case illustrates why that is:
> The tegra host1x driver calls into the debugfs functions if
> CONFIG_DEBUG_FS is enabled, but that code is otherwise already
> discarded by the compiler, so leaving the prototype in place
> actually makes everything work.
> 
> drivers/gpu/host1x/drm/dc.c: In function 'tegra_dc_debugfs_init':
> drivers/gpu/host1x/drm/dc.c:1004:2: error: implicit declaration of function 'drm_debugfs_create_files' [-Werror=implicit-function-declaration]
> drivers/gpu/host1x/drm/dc.c: In function 'tegra_dc_debugfs_exit': drivers/gpu/host1x/drm/dc.c:1026:2: error: implicit declaration of function 'drm_debugfs_remove_files' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Ben Gamari <bgamari@gmail.com>
> Cc: Dave Airlie <airlied@redhat.com>
> 
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index 63d17ee..8bc105e 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -1551,7 +1551,7 @@ extern int drm_proc_init(struct drm_minor *minor, struct proc_dir_entry *root);
>  extern int drm_proc_cleanup(struct drm_minor *minor, struct proc_dir_entry *root);
>  
>  				/* Debugfs support */
> -#if defined(CONFIG_DEBUG_FS)
> +

I don't know what good the blank line does here, but apart from that
this patch looks good to me:

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130622/d59c469a/attachment-0001.sig>
