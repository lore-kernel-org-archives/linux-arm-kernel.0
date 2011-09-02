From: phil.sutter@viprinet.com (Phil Sutter)
Date: Fri, 2 Sep 2011 15:59:55 +0200
Subject: [PATCH] af_packet: flush complete kernel cache in packet_sendmsg
In-Reply-To: <1314971179.3092.159.camel@deadeye>
References: <20110505141107.GC30443@orbit.nwl.cc>
	<1314961686-30870-1-git-send-email-phil.sutter@viprinet.com>
	<1314971179.3092.159.camel@deadeye>
Message-ID: <20110902135954.GA29025@philter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 02:46:17PM +0100, Ben Hutchings wrote:
> On Fri, 2011-09-02 at 13:08 +0200, Phil Sutter wrote:
> > This flushes the cache before and after accessing the mmapped packet
> > buffer. It seems like the call to flush_dcache_page from inside
> > __packet_get_status is not enough on Kirkwood (or ARM in general).
> > ---
> > I know this is far from an optimal solution, but it's in fact the only working
> > one I found.
> [...]
> 
> This is ridiculous.  If flush_dcache_page() isn't doing everything it
> should, you need to fix that.

You're absolutely correct. But in fact this problem goes way too deep
for me to find it's cause. And since my time is finite, I doubt this
will change in the near future. So I asked for help, a pointer in
whatever direction or anything I could try to help further analyzing -
without any response (unless I missed it, in which case I apologize).

Please don't get me wrong. I have no intend in this patch becoming
mainline, just want to give others with the same problem a starting
point.

Greetings, Phil
-- 
Viprinet GmbH
Mainzer Str. 43
55411 Bingen am Rhein
Germany

Zentrale:     +49-6721-49030-0
Durchwahl:    +49-6721-49030-134
Fax:          +49-6721-49030-209

phil.sutter at viprinet.com
http://www.viprinet.com

Sitz der Gesellschaft: Bingen am Rhein
Handelsregister: Amtsgericht Mainz HRB40380
Gesch?ftsf?hrer: Simon Kissel
