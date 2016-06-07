From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 7 Jun 2016 13:06:00 +0100
Subject: HDLCD crashes with 6d910bfa809e
Message-ID: <5756B8A8.8000902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel, Liviu,

Having just inadvertently merged -next into my working branch, I find 
dev6d910bfa809e ("drm/hlcd: Use lockless gem BO free callback") 
adversely affecting my board's ability to boot ;)

Since I (intentionally) don't have sufficient CMA to create a 
framebuffer, drm_gem_cma_create() fails, unconditionally calls the 
now-NULL drm->driver->gem_free_object() in its cleanup path, and fiery 
death ensues...

Regards,
Robin.
