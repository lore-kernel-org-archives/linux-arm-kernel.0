From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 11:19:51 +0100
Subject: [PATCH 1/6] ARM: prefetch: remove redundant "cc" clobber
In-Reply-To: <alpine.LFD.2.03.1307231547010.15022@syhkavp.arg>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-2-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307231547010.15022@syhkavp.arg>
Message-ID: <20130724101950.GG9629@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Jul 23, 2013 at 08:48:11PM +0100, Nicolas Pitre wrote:
> On Tue, 23 Jul 2013, Will Deacon wrote:
> 
> > The pld instruction does not affect the condition flags, so don't bother
> > clobbering them.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks for reviewing the series, much appreciated.

> You know the legacy reason why the cc clobber was there, right?
> It certainly doesn't apply anymore.

I was under the impression that it was due to ancient GCC behaviour and the "cc"
was there to prevent re-ordering. For interest, what are the specifics?

Cheers,

Will
