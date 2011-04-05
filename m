From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 05 Apr 2011 22:24:07 +0300
Subject: [PATCH 00/34] Make kernel build deterministic
In-Reply-To: <20110405154918.GA31337@suse.de>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
	<20110405154918.GA31337@suse.de>
Message-ID: <1302031447.2608.41.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-04-05 at 08:49 -0700, Greg KH wrote:
> On Tue, Apr 05, 2011 at 04:58:47PM +0200, Michal Marek wrote:
> > 
> > Hi,
> > 
> > this series makes it possible to build bit-identical kernel image and
> > modules from identical sources. Of course the build is already
> > deterministic in terms of behavior of the code, but the various
> > timestamps embedded in the object files make it hard to compare two
> > builds, for instance to verify that a makefile cleanup didn't
> > accidentally change something. A prime example is /proc/config.gz, which
> > has both a timestamp in the gzip header and a timestamp in the payload
> > data. With this series applied, a script like this will produce
> > identical kernels each time:
> 
> Very nice stuff.  Do you want to take the individual patches through one
> of your trees, or do you mind if the subsystem maintainers take them
> through theirs?

But unfortunately, it is very easy to break this and for sure it'll be
broken very soon.

So additionally, I'd suggest:
1. Instrument checkpatch.pl and make it err or warn on timestamps.
2. Probably instrument linux-next to rise a warning when people break
   this.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
