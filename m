From: joe@perches.com (Joe Perches)
Date: Mon, 09 Aug 2010 22:36:37 -0700
Subject: [PATCH v3] arm: msm: Add MSM IOMMU support.
In-Reply-To: <bf2b5539fdb03a1a9c55ee1122c40b99.squirrel@www.codeaurora.org>
References: <1281407259-28626-1-git-send-email-stepanm@codeaurora.org>
	<1281409689.1954.96.camel@Joe-Laptop.home>
	<bf2b5539fdb03a1a9c55ee1122c40b99.squirrel@www.codeaurora.org>
Message-ID: <1281418597.1954.106.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-09 at 20:42 -0700, stepanm at codeaurora.org wrote:
> I am actually considering doing away with all the pr_err lines entirely
> because they typically also result in returning -Ewhatever and other IOMMU
> drivers don't give this level of error reporting. But, they may be helpful
> to the users of the API. What are people's thoughts on this?

I believe the current uses of pr_err in this module
are unnecessary or could be converted to pr_debug.

I think __func__/line aren't particularly useful.

I prefer log messages prefixed with the module name.

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

and I'd convert all the current pr_err to pr_debug
and convert the printk(KERN_ERR to pr_err(

cheers, Joe
