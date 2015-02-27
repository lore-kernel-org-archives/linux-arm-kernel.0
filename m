From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Feb 2015 19:08:03 +0000
Subject: [RFC PATCH] ARM64: cmpxchg.h: Clear the exclusive access bit on
 fail
In-Reply-To: <CAJhHMCBwgi96jyAi0Sdi_tEephLjKuG2DQcWa=tv7d7aEbKuaA@mail.gmail.com>
References: <1425016026-19766-1-git-send-email-bobby.prani@gmail.com>
 <20150227100612.GB3628@arm.com>
 <CAJhHMCC98dPnx=ng3zp5ZZmzOZkdPXaA1bmcQJuhQj9wb7CRhw@mail.gmail.com>
 <20150227183301.GL17949@e104818-lin.cambridge.arm.com>
 <CAJhHMCBwgi96jyAi0Sdi_tEephLjKuG2DQcWa=tv7d7aEbKuaA@mail.gmail.com>
Message-ID: <20150227190800.GE9011@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 06:44:19PM +0000, Pranith Kumar wrote:
> On Fri, Feb 27, 2015 at 1:33 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > It's either badly formatted or I don't get it. Are the "stxr x1" and
> > "stxr x7" happening on the same CPU (P0)? If yes, that's badly written
> > code, not even architecturally compliant (you are not allowed other
> > memory accesses between ldxr and stxr).
> 
> OK. Is that the same case with ldaxr (acquire) and stlxr (release)?
> AFAIK, memory accesses between acquire and release exclusive
> operations are allowed.

The restriction on memory accesses in the middle of a load-exclusive
store-exclusive sequence applies to all the load/store-exclusive
variants, including ldaxr and stlxr.

Thanks,
Mark.
