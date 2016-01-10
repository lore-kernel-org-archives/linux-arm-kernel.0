From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 21:29:06 +0200
Subject: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
In-Reply-To: <1452439051.7773.27.camel@perches.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
 <1452427000-4520-2-git-send-email-mst@redhat.com>
 <1452438425.7773.21.camel@perches.com>
 <1452439051.7773.27.camel@perches.com>
Message-ID: <20160110212531-mutt-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 10, 2016 at 07:17:31AM -0800, Joe Perches wrote:
> On Sun, 2016-01-10 at 07:07 -0800, Joe Perches wrote:
> > On Sun, 2016-01-10 at 13:56 +0200, Michael S. Tsirkin wrote:
> > > SMP-only barriers were missing in checkpatch.pl
> > > 
> > > Refactor code slightly to make adding more variants easier.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > If I use a variable called $smp_barriers, I'd expect
> > it to actually be the smp_barriers, not to have to
> > prefix it with smp_ before using it.
> > 
> > 		my $smp_barriers = qr{
> > 			smp_store_release|
> > 			smp_load_acquire|
> > 			smp_store_mb|
> > 			smp_read_barrier_depends
> 
> That's missing (?:barriers) too.

My version has it but need to add ?: to avoid
a capture group.

> btw: shouldn't this also have
> 	smp_mb__(?:before|after)_atomic
> ?

Good catch, included in the next version.

-- 
MST
