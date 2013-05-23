From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 May 2013 00:15:31 +0100
Subject: [PATCH] ARM: avoid mis-detecting some V7 cores in the decompressor
In-Reply-To: <519E57D2.3050000@codeaurora.org>
References: <1368049671-22879-1-git-send-email-sboyd@codeaurora.org>
 <5193E424.9090605@codeaurora.org> <519E57D2.3050000@codeaurora.org>
Message-ID: <20130523231531.GT18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 10:54:26AM -0700, Stephen Boyd wrote:
> On 05/15/13 12:38, Stephen Boyd wrote:
> > On 05/08/13 14:47, Stephen Boyd wrote:
> >> From: Brian Swetland <swetland@google.com>
> >>
> >> Currently v7 CPUs with an MIDR that has no bits set in the range
> >> [16:12] will be detected as old ARM CPUs with no caches and so
> >> the cache will never be turned on during decompression. ARM's
> >> Cortex chips have an 0xC in the range [16:12] so they never match
> >> this entry, but Qualcomm's Scorpion and Krait processors never
> >> set these bits to anything besides 0 so they always match.
> >>
> >> Skip this entry if we've compiled in support for v7 CPUs. This
> >> allows kernel decompression to happen nearly instantly instead of
> >> taking over 20 seconds.
> >>
> >> Signed-off-by: Brian Swetland <swetland@google.com>
> >> [sboyd: Clarified and extended commit text]
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> >> ---
> > Ping?
> 
> Russell, shall I add this to the patch tracker?

Yes please.
