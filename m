From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 23 Sep 2016 18:27:07 +0900
Subject: [PATCH v2 0/3] arm64: kgdb: fix single stepping
In-Reply-To: <20160923084341.GA32342@kroah.com>
References: <20160923073327.9657-1-takahiro.akashi@linaro.org>
 <20160923081618.GH18056@kroah.com>
 <20160923083257.GL30248@linaro.org>
 <20160923084341.GA32342@kroah.com>
Message-ID: <20160923092706.GN30248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 10:43:41AM +0200, Greg KH wrote:
> On Fri, Sep 23, 2016 at 05:32:58PM +0900, AKASHI Takahiro wrote:
> > On Fri, Sep 23, 2016 at 10:16:18AM +0200, Greg KH wrote:
> > > On Fri, Sep 23, 2016 at 04:33:24PM +0900, AKASHI Takahiro wrote:
> > > > Kgdb support on arm64 was merged in v3.15, but from its first appearance,
> > > > "signle step" has never worked well.
> > > > 
> > > > This patch fixes all the error cases I found so far.
> > > > The original patch[1] was splitted into three pieces, ones for each case.
> > > > patch#1, #2 should be applied to all the version, v3.15 and later.
> > > > pathc#3 only for v3.16 and later.
> > > 
> > > As this is not a regression (i.e. it has never worked), why is this
> > > something for stable releases?
> > 
> > Because, I think, that is a bug.
> > The author seems to have believed that it worked.
> > Please see:
> >   commit 44679a4f
> >   Author: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> >   Date:   Tue Jan 28 11:20:19 2014 +0000
> > 
> >       arm64: KGDB: Add step debugging support
> 
> Yes, but again, it didn't work, so this would be a new feature.

Yes, but again, it's a bug of kgdb on arm64 which is supposed
to have been available since v3.15.

> One
> that obviously people aren't using in the stable kernels, otherwise they
> would have noticed in the past 2 years about it being broken :)

Totally agree. That is also why I've left this patch untouched
for a long time. But recently a guy asked me about kgdb, saying that
single step didn't work on his platform. He re-discovered this bug.
He doesn't use stable kernels, but Linaro's LSK (v4.4), though :)

> Please read Documentation/stable_kernel_rules.txt for the requirements
> of a stable kernel patch.  I don't think this series meets those rules.

Please re-think about merging this patch.

Thanks,
-Takahiro AKASHI

> thanks,
> 
> greg k-h
