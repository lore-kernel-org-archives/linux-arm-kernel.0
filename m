From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 9 Dec 2012 08:21:33 +0100 (CET)
Subject: [PATCH] drivers/video/wm8505fb.c: use devm_ functions
In-Reply-To: <1355002958.14981.11.camel@gitbox>
References: <1354984288-773-1-git-send-email-Julia.Lawall@lip6.fr>
 <1355002958.14981.11.camel@gitbox>
Message-ID: <alpine.DEB.2.02.1212090820270.2028@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Rather than the goto, add the fail path code in directly, and return.
>
>
> ret = register_framebuffer(&fbi->fb);
> if (ret < 0) {
>  dev_err(&pdev->dev,
>  "Failed to register framebuffer device: %d\n", ret);
>  if (fbi->fb.cmap.len)
>    fb_dealloc_cmap(&fbi->fb.cmap);
>  return ret;
> }

So there is no need for the platform_set_drvdata(pdev, NULL); ?

Also, do you know if it is correct that the original code does not include
a call to dma_free_coherent?

thanks,
julia
