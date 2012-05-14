From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 May 2012 18:57:29 +0100
Subject: [PATCH v4 2/2] ARM: vfp: clear fpscr length and stride bits on
 entry to sig handler
In-Reply-To: <1337017844.16954.49.camel@linaro1.home>
References: <1330009632-1235-1-git-send-email-will.deacon@arm.com>
 <1330009632-1235-2-git-send-email-will.deacon@arm.com>
 <1337006035.16954.21.camel@linaro1.home>
 <20120514145931.GF11088@mudshark.cambridge.arm.com>
 <1337011379.16954.40.camel@linaro1.home>
 <20120514173757.GJ11088@mudshark.cambridge.arm.com>
 <1337017844.16954.49.camel@linaro1.home>
Message-ID: <20120514175728.GK11088@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 06:50:44PM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2012-05-14 at 18:37 +0100, Will Deacon wrote:
> > You're right, in the lazy case (i.e. SMP) we update the hwstate on
> > context-switch rather than on the fault. Your quick fix looks good to me
> > (that is, unconditionally flushing the state after handling a signal). I was
> > initially worried that the added flushing would cause a performance hit on
> > the usual path, where VFP is not used in the handler, however since we flush
> > before the signal handler, it really won't make a lot of difference.
> > 
> > I took the liberty of writing a commit message, so can I add your S-o-B to
> > this please (I wasn't sure which email address to use)?
> 
> Thanks, it's the day job, so...
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Cheers Jon, I'll stick this in the patch system tomorrow. If it doesn't make
the final cut, I'll retrospectively send it to stable when they move to
3.4.

Will
