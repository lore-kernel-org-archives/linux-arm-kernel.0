From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 15:09:39 -0800
Subject: [PATCH v2 08/18] arm64: don't disable ADR_PREL_PG_HI21* with
 ARM64_ERRATUM_843419
In-Reply-To: <CAKv+Gu_3R4SUC2hCUtEX_4ut9admtrBZS-S-mzQnQsoJoHPcBw@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-9-samitolvanen@google.com>
 <CAKv+Gu-wYwBMV7tdb+Kax_cyPsmAB2R2ZVwJuNi9qM0kaYAs=Q@mail.gmail.com>
 <20171116114406.GB9361@arm.com>
 <20171116163132.GC94341@samitolvanen.mtv.corp.google.com>
 <CAKv+Gu8yPSwZep-S_ke_P5BiZ3o72R=ykhixoXcyGUHa1ZxGGw@mail.gmail.com>
 <20171116213702.GA10616@samitolvanen.mtv.corp.google.com>
 <CAKv+Gu_3R4SUC2hCUtEX_4ut9admtrBZS-S-mzQnQsoJoHPcBw@mail.gmail.com>
Message-ID: <20171116230939.GA38360@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 10:14:17PM +0000, Ard Biesheuvel wrote:
> OK, so my concern here is that this code probably only operates on
> fully linked binaries, and not partially linked object files like
> kernel modules.

Right. That makes sense.

> What is preventing us from using the large model with clang?

We pass -mcmodel=large to clang, but I just confirmed that the
attribute isn't stored in LLVM IR, which means it's not used during
link time compilation. I'll see if we can solve this problem by
passing the correct code model directly to LLVMgold instead. Thanks
for pointing this out.

Sami
