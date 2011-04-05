From: gregkh@suse.de (Greg KH)
Date: Tue, 5 Apr 2011 08:49:18 -0700
Subject: [PATCH 00/34] Make kernel build deterministic
In-Reply-To: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
Message-ID: <20110405154918.GA31337@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 04:58:47PM +0200, Michal Marek wrote:
> 
> Hi,
> 
> this series makes it possible to build bit-identical kernel image and
> modules from identical sources. Of course the build is already
> deterministic in terms of behavior of the code, but the various
> timestamps embedded in the object files make it hard to compare two
> builds, for instance to verify that a makefile cleanup didn't
> accidentally change something. A prime example is /proc/config.gz, which
> has both a timestamp in the gzip header and a timestamp in the payload
> data. With this series applied, a script like this will produce
> identical kernels each time:

Very nice stuff.  Do you want to take the individual patches through one
of your trees, or do you mind if the subsystem maintainers take them
through theirs?

thanks,

greg k-h
