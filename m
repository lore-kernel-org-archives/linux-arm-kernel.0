From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Nov 2018 02:51:21 +0000
Subject: [PATCHv3 1/6] atomics: add common header generation files
In-Reply-To: <20181115151048.26244bad301a3bcb9a450060@linux-foundation.org>
References: <20180904104830.2975-1-mark.rutland@arm.com>
 <20180904104830.2975-2-mark.rutland@arm.com>
 <20181115151048.26244bad301a3bcb9a450060@linux-foundation.org>
Message-ID: <20181116025112.xhbfei677awm77ji@blommer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Nov 15, 2018 at 03:10:48PM -0800, Andrew Morton wrote:
> On Tue,  4 Sep 2018 11:48:25 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > To minimize repetition, to allow for future rework, and to ensure
> > regularity of the various atomic APIs, we'd like to automatically
> > generate (the bulk of) a number of headers related to atomics.
> > 
> > This patch adds the infrastructure to do so, leaving actual conversion
> > of headers to subsequent patches.
> 
> This thing is appallingly slow.  `sh scripts/atomic/check-atomics.sh'
> takes 8 seconds on a machine which builds an allnoconfig kernel in 30
> seconds.

Hmm... on my laptop it's less than half that, and allnoconfig takes ~35s, so
clearly there's a major difference between our setups.

For reference, which distro are you using, and what is /bin/sh on your box?
 
> Um, no.  Just no.  Please find a way to make this overhead go away.

Will do.

Trivially, switching to diff -q halves the check runtime for me, and I'm sure
there are other parts of the scripting which can be optimized.

Thanks,
Mark.
