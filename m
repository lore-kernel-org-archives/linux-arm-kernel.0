From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 2 Mar 2017 17:25:20 +0100
Subject: [PATCH] drm/atmel-hlcdc: Rework the fbdev creation logic
In-Reply-To: <9eef519a-57ea-a677-4bdc-a4198fb646b5@gmail.com>
References: <1480345267-18461-1-git-send-email-boris.brezillon@free-electrons.com>
 <9eef519a-57ea-a677-4bdc-a4198fb646b5@gmail.com>
Message-ID: <20170302172520.567c6f96@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Mar 2017 17:04:51 +0100
Richard Genoud <richard.genoud@gmail.com> wrote:

> On 28/11/2016 16:01, Boris Brezillon wrote:
> > Now that we wait for DRM panels to be available before registering the
> > DRM device (returning -EPROBE_DEFER if the panel has not been probed
> > yet), we no longer need to put the fbdev creation code in  
> > ->output_poll_changed().  
> > 
> > This removes the 10 secs delay between DRM dev registration and fbdev
> > creation (polling period = 10 seconds).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Reported-by: Alex Vazquez <avazquez.dev@gmail.com>  
> Tested-by: Richard Genoud <richard.genoud@gmail.com>
> 
> Those 10 seconds where a real pain !
> Any reason this has not been applied ?

It should show up in 4.11 (it's already in Linus' tree [1] ;-)).

Regards,

Boris

[1]https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/atmel-hlcdc?id=db02b7614a54bf0bf548db07bc8d3e7518fd9481
