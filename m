From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Sep 2012 11:32:12 +0100
Subject: [RFC PATCH v2 2/5] ARM: mm: rename jump labels in
 v7_flush_dcache_all function
In-Reply-To: <20120919135155.GB2111@linaro.org>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20120919135155.GB2111@linaro.org>
Message-ID: <20120920103212.GE4588@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 02:51:56PM +0100, Dave Martin wrote:
> On Tue, Sep 18, 2012 at 05:35:32PM +0100, Lorenzo Pieralisi wrote:
> > This patch renames jump labels in v7_flush_dcache_all in order to define
> > a specific flush cache levels entry point.
> > 
> > TODO: factor out the level flushing loop if considered worthwhile and
> >       define the input registers requirements.
> 
> In the context of this series, this patch seems to do nothing at all (?)

Agreed, it is just replacing some labels. I thought that something like:

b flush_levels

is clearer than:

b loop1

If I manage to factor out the cache level flushing loop I think things
are even better, I just did not want to change v7_flush_dcache_all, I would
avoid doing that, unless, as I mentioned, it is considered worthwhile.

> Maybe it would make sense to defer this patch until you post something
> that uses it.

v7_flush_dcache_louis uses it, I have no problem in deferring it though.

Lorenzo
