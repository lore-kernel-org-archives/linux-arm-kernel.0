From: emilgoode@gmail.com (Emil Goode)
Date: Thu, 22 May 2014 16:44:46 +0200
Subject: [PATCH] ARM: imx: add missing kfree call in error paths
In-Reply-To: <20140522135016.GK15585@mwanda>
References: <1400764482-20147-1-git-send-email-emilgoode@gmail.com>
 <20140522135016.GK15585@mwanda>
Message-ID: <20140522144446.GA7348@lianli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dan,

On Thu, May 22, 2014 at 04:50:16PM +0300, Dan Carpenter wrote:
> On Thu, May 22, 2014 at 03:14:42PM +0200, Emil Goode wrote:
> > We forgot to free pdev->dev.dma_mask as it is not freed
> > by platform_device_put().
> > 
> 
> Every function which calls imx31_alloc_mx3_camera() is buggy.  That
> means that, at best, it is a 2 on Rusty's API rating.
> http://sweng.the-davies.net/Home/rustys-api-design-manifesto
> 
> The correct fix is to introduce an imx31_free_mx3_camera() otherwise we
> will just keep introducing these bugs.

I guess I could add this to arch/arm/mach-imx/devices/platform-ipu-core.c
it would be a very small function though.

Best regards,

Emil Goode
