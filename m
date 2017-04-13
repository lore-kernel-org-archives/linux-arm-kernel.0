From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 13 Apr 2017 13:33:09 +0300
Subject: [RFC PATCH 0/3] arm64: queued spinlocks and rw-locks
In-Reply-To: <a4f067df-4c22-5c90-d70a-809903c60296@codeaurora.org>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <a4f067df-4c22-5c90-d70a-809903c60296@codeaurora.org>
Message-ID: <20170413103309.GA1875@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 01:04:55PM -0400, Adam Wallis wrote:
> On 4/10/2017 5:35 PM, Yury Norov wrote:
> > The patch of Jan Glauber enables queued spinlocks on arm64. I rebased it on
> > latest kernel sources, and added a couple of fixes to headers to apply it 
> > smoothly.
> > 
> > Though, locktourture test shows significant performance degradation in the
> > acquisition of rw-lock for read on qemu:
> > 
> >                           Before           After
> > spin_lock-torture:      38957034        37076367         -4.83
> > rw_lock-torture W:       5369471        18971957        253.33
> > rw_lock-torture R:       6413179         3668160        -42.80
> > 
> 
> On our 48 core QDF2400 part, I am seeing huge improvements with these patches on
> the torture tests. The improvements go up even further when I apply Jason Low's
> MCS Spinlock patch: https://lkml.org/lkml/2016/4/20/725

It sounds great. So performance issue is looking like my local
problem, most probably because I ran tests on Qemu VM.

I don't see any problems with this series, other than performance,
and if it looks fine now, I think it's good enough for upstream.

Yury.
