From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Apr 2018 15:17:29 +0100
Subject: [PATCH] arm64: support __int128 with clang
In-Reply-To: <20180424135608.m5uxhmclhnljpbau@lakrids.cambridge.arm.com>
References: <20171223004323.1986-1-Jason@zx2c4.com>
 <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
 <20180424133527.GB24599@arm.com>
 <20180424135608.m5uxhmclhnljpbau@lakrids.cambridge.arm.com>
Message-ID: <20180424141729.r7wfnos3p2kdt3ez@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 02:56:09PM +0100, Mark Rutland wrote:
> I belevie that currently it is not possible to use a released version of
> clang to build a working kernel without additional patches (at least
> 5.0.0, there don't seem to be any 6.0.0 binaries that can target
> AArch64). Issues include:
> 
> * Released versions of clang don't support the 's' constraint used in
>   some hyp code.
> 

> * Released versions of clang don't support 'rX' as a register name, as
>   is used by some workaround code shared between arm/arm64.

This case will apparently be fixed for 6.0.1 (and presumably 7.0.0):

https://reviews.llvm.org/rL328829
https://bugs.llvm.org/show_bug.cgi?id=36862

Neither have been released yet.

Mark.
