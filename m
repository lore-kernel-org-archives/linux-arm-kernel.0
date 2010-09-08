From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 8 Sep 2010 11:39:31 -0600
Subject: [PATCH 1/2] OMAP2+: PM: initial runtime PM core support
In-Reply-To: <871v945esf.fsf@deeprootsystems.com>
References: <1283907282-986-1-git-send-email-khilman@deeprootsystems.com>
	<20100908162143.GD3686@angua.secretlab.ca>
	<871v945esf.fsf@deeprootsystems.com>
Message-ID: <20100908173931.GL3686@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 08, 2010 at 10:24:48AM -0700, Kevin Hilman wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > On Tue, Sep 07, 2010 at 05:54:41PM -0700, Kevin Hilman wrote:
> >> +	omap_pm->runtime_suspend = omap_pm_runtime_suspend;
> >> +	omap_pm->runtime_resume = omap_pm_runtime_resume;
> >
> > This will fail to build when CONFIG_PM_RUNTIME is unset.  None of this
> > file should be build when CONFIG_PM_RUNTIME=n.
> 
> FYI... Rather than not building the whole file, I'm fixing this by
> adding an #else clause to the #ifdef:
> 
> #else
> #define omap_pm_runtime_suspend NULL
> #define omap_pm_runtime_resume NULL
> #endif /* CONFIG_PM_RUNTIME */
> 
> This is because I'll also be building on this to hook up the
> _[suspend|resume]_noirq() methods which are based on #ifdef
> CONFIG_SUSPEND and not CONFIG_PM_RUNTIME.

okay.

g.
