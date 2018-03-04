From: jolsa@redhat.com (Jiri Olsa)
Date: Sun, 4 Mar 2018 19:10:10 +0100
Subject: [RFC V2 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
In-Reply-To: <20180304171245.GB25017@tassilo.jf.intel.com>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
 <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
 <20180303143436.GA14563@krava>
 <20180304171245.GB25017@tassilo.jf.intel.com>
Message-ID: <20180304181010.GA7030@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2018 at 09:12:45AM -0800, Andi Kleen wrote:
> > > +#include <fnmatch.h>
> > >  #include <linux/compiler.h>
> > >  #include <linux/list.h>
> > >  #include <linux/types.h>
> > > @@ -241,7 +242,7 @@ PE_NAME opt_event_config
> > >  			if (!strncmp(name, "uncore_", 7) &&
> > >  			    strncmp($1, "uncore_", 7))
> > >  				name += 7;
> > > -			if (!strncmp($1, name, strlen($1))) {
> > > +			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
> > 
> > could we now get rid of the strncmp in here and keep the
> > glob matching only? 
> 
> That would break existing command lines. Not a good idea.

I hoped that only you guys are using this and would rewrite your scripts ;-)

I had no idea there's fnmatch func before.. too bad, ok

jirka
