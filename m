From: liviu.dudau@arm.com (liviu.dudau at arm.com)
Date: Tue, 7 Jun 2016 14:35:35 +0100
Subject: HDLCD crashes with 6d910bfa809e
In-Reply-To: <5756B8A8.8000902@arm.com>
References: <5756B8A8.8000902@arm.com>
Message-ID: <20160607133535.GA1165@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 01:06:00PM +0100, Robin Murphy wrote:
> Hi Daniel, Liviu,

Hi Robin,

> 
> Having just inadvertently merged -next into my working branch, I find
> dev6d910bfa809e ("drm/hlcd: Use lockless gem BO free callback") adversely
> affecting my board's ability to boot ;)
> 
> Since I (intentionally) don't have sufficient CMA to create a framebuffer,
> drm_gem_cma_create() fails, unconditionally calls the now-NULL
> drm->driver->gem_free_object() in its cleanup path, and fiery death
> ensues...

Thanks for reporting this. What other changes other than reducing the CMA
allocation size do you have that I might need in order to reproduce this?

Best regards,
Liviu

> 
> Regards,
> Robin.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
