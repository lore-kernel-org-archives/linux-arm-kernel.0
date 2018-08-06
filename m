From: keescook@chromium.org (Kees Cook)
Date: Mon, 6 Aug 2018 11:49:34 -0700
Subject: [RFC/PoC PATCH 0/3] arm64: basic ROP mitigation
In-Reply-To: <31443e6a-56b4-c4fb-82b1-b8eb5d7eebe1@arm.com>
References: <20180802132133.23999-1-ard.biesheuvel@linaro.org>
 <7529eedf-af56-2e94-261e-bc5c86abadaa@arm.com>
 <CAKv+Gu9X1CDpy+XvrmbSdjBjMb45eBW7JVsvsK_JQdUt2Dbvgw@mail.gmail.com>
 <b0c974a2-4e81-7855-7d4e-22834c5d8997@arm.com>
 <CAKv+Gu_ZzDbWwHVwOuoheXeN-ta_FjOT4Aj15=r56QZVTUK0FA@mail.gmail.com>
 <CAKv+Gu_wGk2Gdzd6WuOMZqz1tKHAWHL7pWm2Szyt0DZwPTCmOw@mail.gmail.com>
 <31443e6a-56b4-c4fb-82b1-b8eb5d7eebe1@arm.com>
Message-ID: <CAGXu5jLj=KP038d-c+xzCx=Oogn1prH__oryQjNZZwNaAHaAAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2018 at 10:45 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> I guess what I'm getting at is that if the protection mechanism is "always
> return with SP outside TTBR1", there seems little point in going through the
> motions if SP in TTBR0 could still be valid and allow an attack to succeed
> anyway; this is basically just me working through a justification for saying
> the proposed scheme needs "depends on ARM64_PAN || ARM64_SW_TTBR0_PAN",
> making it that much uglier for v8.0 CPUs...

I think anyone with v8.0 CPUs interested in this mitigation would also
very much want PAN emulation. If a "depends on" isn't desired, what
about "imply" in the Kconfig?

-Kees

-- 
Kees Cook
Pixel Security
