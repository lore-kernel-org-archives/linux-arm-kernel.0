From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 25 Jan 2018 12:44:34 +0000
Subject: [PATCH] arm64: turn off xgene branch prediction while in kernel
 space
In-Reply-To: <20180124164324.GA30462@arm.com>
References: <1516760007-14670-1-git-send-email-kdinh@apm.com>
 <aacf7d03-faa7-c17d-b763-c80b293106ea@arm.com>
 <1516811703.2957.47.camel@redhat.com> <20180124164324.GA30462@arm.com>
Message-ID: <13f48247088a49b0a4a9afef0aa576a7@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon
> Sent: 24 January 2018 16:43
> On Wed, Jan 24, 2018 at 11:35:03AM -0500, Mark Salter wrote:
> > On Wed, 2018-01-24 at 10:58 +0000, Marc Zyngier wrote:
> > > Khuong,
> > >
> > > On 24/01/18 02:13, Khuong Dinh wrote:
> > > > Aliasing attacks against CPU branch predictors can allow an attacker to
> > > > redirect speculative control flow on some CPUs and potentially divulge
> > > > information from one context to another.
> > > >
> > > > This patch only supports for XGene processors.
...
> > > Why isn't this using the infrastructure that is already in place?
> >
> > That infrastructure relies on a cpu-specific flush of the branch
> > predictor. XGene does not have the ability to flush the branch
> > predictor. It can only turn it on or off.
> 
> So how does this patch protect one user application from another? Sounds
> like you need to turn the thing off at boot and leave it that way, or find
> a sequence of branch instructions to effectively do the invalidation.

What sort of performance penalty does this give?
I can imagine it is significant.

Attempting to flush a branch predictor is also likely to be very slow.

	David
