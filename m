From: bobby.prani@gmail.com (Pranith Kumar)
Date: Tue, 3 Mar 2015 11:58:26 -0500
Subject: [RFC PATCH] arm64: cmpxchg.h: Bring ldxr and stxr closer
In-Reply-To: <20150303143454.GN28951@e104818-lin.cambridge.arm.com>
References: <1425067776-2794-1-git-send-email-bobby.prani@gmail.com>
 <20150227201526.GH24818@arm.com>
 <CAJhHMCA0La6rQBndxJDnynAZ6AogEbKcCRQULZjjRTXBMzGuiA@mail.gmail.com>
 <CAJhHMCDUqvxs4rwsnw69UyM5NoBTit_HoYzdWpSYibbXtRs=5g@mail.gmail.com>
 <20150303143454.GN28951@e104818-lin.cambridge.arm.com>
Message-ID: <CAJhHMCBVTF0keDzqxi0Mw=8SM5gSUxE8D4c5-oHAOg1bUkBYEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 3, 2015 at 9:34 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Do you mean the cmpxchg_double() change? Becuase %w0 and %0 is the same
> physical register. You set it to 0 and immediately override it with
> ldxp.
>

Thanks Catalin. I realized the blunder a while after Will pointed it
out. The asm here was a bit confusing. %0 usually refers to the first
input/output variable. But for ldxp instruction(which is just a
double-word load, not exclusive), it refers to the physical registers.

What about the changes in cmpxchg()? Why do we need to set %w0 to 0
after the ldxrh instruction? Also, could you please point me to any
arm64 asm reference?

Thanks!
-- 
Pranith
