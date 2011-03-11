From: sam@ravnborg.org (Sam Ravnborg)
Date: Fri, 11 Mar 2011 06:47:15 +0100
Subject: [PATCH] kbuild: reenable section mismatch analysis
In-Reply-To: <20110310164100.5af81e3b.akpm@linux-foundation.org>
References: <20110216200734.GA25184@merkur.ravnborg.org>
	<1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110310164100.5af81e3b.akpm@linux-foundation.org>
Message-ID: <20110311054715.GA32246@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 04:41:00PM -0800, Andrew Morton wrote:
> On Fri, 18 Feb 2011 21:47:20 +0100
> Uwe Kleine-K__nig  <u.kleine-koenig@pengutronix.de> wrote:
> 
> > This was disabled in commit
> > 
> > 	e5f95c8 (kbuild: print only total number of section mismatces found)
> > 
> > because there were too many warnings.  Now we're down to a reasonable
> > number again, so we start scaring people with the details.
> > 
> > Signed-off-by: Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  lib/Kconfig.debug |    4 ----
> >  1 files changed, 0 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2b97418..0f77ed1 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -102,11 +102,7 @@ config HEADERS_CHECK
> >  
> >  config DEBUG_SECTION_MISMATCH
> >  	bool "Enable full Section mismatch analysis"
> > -	depends on UNDEFINED || (BLACKFIN)
> >  	default y
> > -	# This option is on purpose disabled for now.
> > -	# It will be enabled when we are down to a reasonable number
> > -	# of section mismatch warnings (< 10 for an allyesconfig build)
> >  	help
> >  	  The section mismatch analysis checks if there are illegal
> >  	  references from one section to another section.
> 
> eaaaargh!  650 lines of crap added to my i386 allmodconfig build output.
> 
> I'll be locally opting out of this one, thanks.

How about that we enable this in the merge window.
And if it continue to be unreasonable then drop it again
around rc5 time?

The likelyhood that warnings are fixed is bigger if people
see them and get annoyed.

	Sam
