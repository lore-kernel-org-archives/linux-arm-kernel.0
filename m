From: tj@kernel.org (Tejun Heo)
Date: Mon, 24 Oct 2011 13:19:07 -0700
Subject: [RFC 3/4] lib: devres: add convenience function to remap a
	resource
In-Reply-To: <20111024200933.GB6326@pengutronix.de>
References: <1319445729-14841-1-git-send-email-w.sang@pengutronix.de>
	<1319445729-14841-4-git-send-email-w.sang@pengutronix.de>
	<20111024154307.GB24914@google.com>
	<20111024200933.GB6326@pengutronix.de>
Message-ID: <20111024201907.GD24914@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 10:09:33PM +0200, Wolfram Sang wrote:
> > So, for library functions, it's nice if the function doesn't hold any
> > extra resource on error return.  devres has grouping to support this.
> > You just need to wrap allocations inside a group and remove it on
> > success and release on error.  ie.
> > 
> > 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> > 		return NULL;
> > 	if (alloc_resource(0) < 0)
> > 		goto fail;
> > 	if (alloc_resource(1) < 0)
> > 		goto fail;
> > 	devres_remove_group(dev, NULL);
> > 	return 0;
> > fail:
> > 	devres_release_group(dev, NULL);
> > 	return 0;
> 
> I am not sure I got what you mean here, but wouldn't it be easier to simply
> call devm_release_mem_region() when devm_ioremap comes back with a NULL
> pointer?

Oh, yeah, that would work too. :)

Thanks.

-- 
tejun
