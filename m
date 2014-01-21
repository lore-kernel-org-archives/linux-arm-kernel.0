From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 21 Jan 2014 16:35:56 +0300
Subject: [patch] drm/exynos: potential use after free in exynos_drm_open()
In-Reply-To: <52DE6B8B.6080304@bfs.de>
References: <20140121065748.GC31535@elgon.mountain> <52DE69F3.9070307@bfs.de>
 <52DE6B8B.6080304@bfs.de>
Message-ID: <20140121133556.GY7444@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 01:43:55PM +0100, walter harms wrote:
> 
> i have just noticed: The function already exits
> 
> 194 static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
> 195 {
> 196         if (!file->driver_priv)
> 197                 return;
> 198
> 199         kfree(file->driver_priv);
> 200         file->driver_priv = NULL;
> 201 }

The function is different in the current code.  I glanced through
drm_open_helper() and I don't see that file->driver_priv to NULL is
needed anyway...

regards,
dan carpenter
