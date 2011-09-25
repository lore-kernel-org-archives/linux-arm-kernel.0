From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Sep 2011 20:30:12 +0100
Subject: I-cache/D-cache inconsistency issue with page cache
In-Reply-To: <CAHkRjk7u3RQxUSkU+DP0fD4qd2VzYB0eQA_NpVFebNtBcR6ysQ@mail.gmail.com>
References: <20110923115721.GA7013@glandium.org>
	<20110923193941.GQ17169@n2100.arm.linux.org.uk>
	<20110924093544.GA5724@glandium.org>
	<20110924094734.GC17169@n2100.arm.linux.org.uk>
	<CAHkRjk42PoRJrRb3vBdQCCno_LoMSdBrHSQ9xkiFcyB16PYkaw@mail.gmail.com>
	<20110925103445.GA22455@n2100.arm.linux.org.uk>
	<CAHkRjk7u3RQxUSkU+DP0fD4qd2VzYB0eQA_NpVFebNtBcR6ysQ@mail.gmail.com>
Message-ID: <20110925193012.GC22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 25, 2011 at 04:26:42PM +0100, Catalin Marinas wrote:
> On 25 September 2011 11:34, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > As I've already pointed out though, the report is against old kernels
> > which doesn't have this code, so there's no point us speculating about
> > it until the issue has been confirmed against a kernel which we expect
> > _not_ to have the issue in the first place (rather than one which we
> > _do_ expect it to go wrong.)
> 
> Yes, they should definitely try a more recent kernel.

As the kernels which have been reported as having the issue do not
have __sync_icache_dcache, all bets are off for things behaving
correctly.  I don't see any point speculating further until the
problem is confirmed on a kernel _with_ __sync_icache_dcache.
