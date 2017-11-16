From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 16 Nov 2017 17:59:22 +0100
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <CAKwvOdkV_g0XAbGM+nF2zt=2+tHLLcj=pbSxRDd2HMbrtU3cZg@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-19-samitolvanen@google.com>
 <20171116115810.GH9361@arm.com>
 <20171116161731.GA94341@samitolvanen.mtv.corp.google.com>
 <20171116163054.kcsdsomr7u2mqql2@hirez.programming.kicks-ass.net>
 <CAKwvOdkV_g0XAbGM+nF2zt=2+tHLLcj=pbSxRDd2HMbrtU3cZg@mail.gmail.com>
Message-ID: <20171116165922.llrojrvomuihabrt@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 08:50:41AM -0800, Nick Desaulniers wrote:
> On Thu, Nov 16, 2017 at 8:30 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Ideally we'd get the toolchain people to commit to supporting the kernel
> > memory model along side the C11 one. That would help a ton.
> 
> Does anyone from the kernel side participate in the C standardization process?

Yes, Paul McKenney and Will Deacon. Doesn't mean these two can still be
reconciled though. From what I understand C11 (and onwards) are
incompatible with the kernel model on a number of subtle points.

Not to mention that there's people in the C11 process that strongly
argue for stuff that would break every single multi-threaded program
written since the 70s, which would include pretty much all OS kernels.
