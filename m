From: tytso@mit.edu (Theodore Ts'o)
Date: Tue, 19 May 2015 10:39:04 -0400
Subject: [PATCH] crypto: allow to assign gfp_t for __crypto_alloc_tfm
In-Reply-To: <20150519142755.GB32663@gondor.apana.org.au>
References: <1432014416-39326-1-git-send-email-jaegeuk@kernel.org>
 <20150519054945.GA28060@gondor.apana.org.au>
 <20150519062430.GA39588@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519063211.GA28347@gondor.apana.org.au>
 <20150519065812.GA40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519065929.GA28610@gondor.apana.org.au>
 <20150519071317.GB40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519071521.GA28862@gondor.apana.org.au>
 <20150519141430.GD20421@thunk.org>
 <20150519142755.GB32663@gondor.apana.org.au>
Message-ID: <20150519143904.GA25684@thunk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 10:27:55PM +0800, Herbert Xu wrote:
> On Tue, May 19, 2015 at 10:14:30AM -0400, Theodore Ts'o wrote:
> > 
> > There can be multiple reads going on in parallel, so we're currently
> > creating tfm's as necessary.  In fact one of the things that we've
> 
> A single tfm is fully-reentrant (as long as you don't change the
> key).  So multiple reads/writes on a single file can all use one
> tfm with no locking at all.

Cool, we didn't realize this was the case.  Excellent, this makes life
much simpler for us!  :-)

Thanks,

					- Ted
