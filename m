From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Aug 2014 09:32:46 +0100
Subject: [PATCH] arm64: optimize memcpy_{from,to}io() and memset_io()
In-Reply-To: <20140801063009.GA24602@codeaurora.org>
References: <1406701706-12808-1-git-send-email-joonwoop@codeaurora.org>
 <20140801063009.GA24602@codeaurora.org>
Message-ID: <20140801083245.GE15733@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 07:30:09AM +0100, Joonwoo Park wrote:
> + Catalin, Will
> 
> Thanks,
> Joonwoo
> On Tue, Jul 29, 2014 at 11:28:26PM -0700, Joonwoo Park wrote:
> > Optimize memcpy_{from,to}io() and memset_io() by transferring in 64 bit
> > as much as possible with minimized barrier usage.  This simplest optimization
> > brings faster throughput compare to current byte-by-byte read and write with
> > barrier in the loop.  Code's skeleton is taken from the powerpc.

Hmm, I've never really understood the use-case for memcpy_{to,from}io on
ARM, so getting to the bottom of that would help in reviewing this patch.

Can you point me at the drivers which are using this for ARM please? Doing a
blind byte-by-byte copy could easily cause problems with some peripherals,
so there must be an underlying assumption somewhere about how this is
supposed to work.

Will
