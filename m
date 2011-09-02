From: bhutchings@solarflare.com (Ben Hutchings)
Date: Fri, 02 Sep 2011 14:46:17 +0100
Subject: [PATCH] af_packet: flush complete kernel cache in packet_sendmsg
In-Reply-To: <1314961686-30870-1-git-send-email-phil.sutter@viprinet.com>
References: <20110505141107.GC30443@orbit.nwl.cc>
	<1314961686-30870-1-git-send-email-phil.sutter@viprinet.com>
Message-ID: <1314971179.3092.159.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-09-02 at 13:08 +0200, Phil Sutter wrote:
> This flushes the cache before and after accessing the mmapped packet
> buffer. It seems like the call to flush_dcache_page from inside
> __packet_get_status is not enough on Kirkwood (or ARM in general).
> ---
> I know this is far from an optimal solution, but it's in fact the only working
> one I found.
[...]

This is ridiculous.  If flush_dcache_page() isn't doing everything it
should, you need to fix that.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
