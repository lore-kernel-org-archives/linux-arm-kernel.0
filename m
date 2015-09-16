From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 16 Sep 2015 15:09:03 -0700
Subject: [PATCH 0/3] Add __ioread32_copy() and use it
In-Reply-To: <20150916005053.GL23081@codeaurora.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
 <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
 <20150916005053.GL23081@codeaurora.org>
Message-ID: <20150916150903.8021ca66ba76cb31f34021a2@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Sep 2015 17:50:53 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:

> > 
> > __iowrite32_copy() is marked __visible.  I don't actually know what
> > that does and Andi's d47d5c8194579bc changelog (which sucks the big
> > one) didn't explain it.  Apparently it has something to do with being
> > implemented in assembly, but zillions of functions are implemented in
> > assembly, so why are only two functions marked this way?  Anyway,
> > __ioread32_copy() is implemented in C so I guess __visible isn't needed
> > there.
> 
> Yeah, I didn't add visible because there isn't an assembly
> version of __ioread32_copy() so far. I can remove __weak if
> desired. I left it there to match __iowrite32_copy() in case
> x86 wanted to override it but we can do that later or never.

OK.  I'd omit the __weak and __visible for now.  They can be added later
if someone needs them.
