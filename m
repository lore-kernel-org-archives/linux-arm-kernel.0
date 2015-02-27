From: bobby.prani@gmail.com (Pranith Kumar)
Date: Fri, 27 Feb 2015 13:44:19 -0500
Subject: [RFC PATCH] ARM64: cmpxchg.h: Clear the exclusive access bit on
 fail
In-Reply-To: <20150227183301.GL17949@e104818-lin.cambridge.arm.com>
References: <1425016026-19766-1-git-send-email-bobby.prani@gmail.com>
 <20150227100612.GB3628@arm.com>
 <CAJhHMCC98dPnx=ng3zp5ZZmzOZkdPXaA1bmcQJuhQj9wb7CRhw@mail.gmail.com>
 <20150227183301.GL17949@e104818-lin.cambridge.arm.com>
Message-ID: <CAJhHMCBwgi96jyAi0Sdi_tEephLjKuG2DQcWa=tv7d7aEbKuaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 1:33 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> It's either badly formatted or I don't get it. Are the "stxr x1" and
> "stxr x7" happening on the same CPU (P0)? If yes, that's badly written
> code, not even architecturally compliant (you are not allowed other
> memory accesses between ldxr and stxr).

OK. Is that the same case with ldaxr (acquire) and stlxr (release)?
AFAIK, memory accesses between acquire and release exclusive
operations are allowed.

>
>>     The last store exclusive succeeds since the exclusive bit is set which
>> should not happen. Clearing the exclusive bit before returning from cmpxchg
>> prevents this happening.
>>
>> Now I am not sure how likely this will happen. One can argue that a cmpxchg()
>> will not happen between an external ldxr/stxr. But isn't clearing the exclusive
>> bit better?
>
> The only way cmpxchg() could happen between a different ldxr/stxr is
> during an interrupt. But ERET automatically clears the exclusive
> monitor, so the "stxr x7" would not succeed.

That makes sense. But please consider the ldaxr/stlxr case and let me know.

Thanks!
-- 
Pranith
