From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Jan 2010 06:35:42 -0800
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <20100129141407.GA16712@n2100.arm.linux.org.uk>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
	<20100129141407.GA16712@n2100.arm.linux.org.uk>
Message-ID: <1264775742.5109.43.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-29 at 14:14 +0000, Russell King - ARM Linux wrote:
> > +static inline void l2x0_flush_all(void)
> > +{
> > +	/* clean and invalidate all ways */
> > +	sync_writel(0xff, L2X0_CLEAN_INV_WAY, 0xff);
> > +	cache_sync();
> > +}
> 
> Note that this patch is out of date; it won't apply to current kernels
> and build.

Do you generally prefer patches against current -rc kernels, or against
-next (or you development tree)?

Daniel
