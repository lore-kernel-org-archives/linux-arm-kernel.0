From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 16 Nov 2017 16:34:03 +0000
Subject: [PATCH v2 08/18] arm64: don't disable ADR_PREL_PG_HI21* with
 ARM64_ERRATUM_843419
In-Reply-To: <20171116163132.GC94341@samitolvanen.mtv.corp.google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-9-samitolvanen@google.com>
 <CAKv+Gu-wYwBMV7tdb+Kax_cyPsmAB2R2ZVwJuNi9qM0kaYAs=Q@mail.gmail.com>
 <20171116114406.GB9361@arm.com>
 <20171116163132.GC94341@samitolvanen.mtv.corp.google.com>
Message-ID: <CAKv+Gu8yPSwZep-S_ke_P5BiZ3o72R=ykhixoXcyGUHa1ZxGGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2017 at 16:32, Sami Tolvanen <samitolvanen@google.com> wrote:
> On Thu, Nov 16, 2017 at 11:44:06AM +0000, Will Deacon wrote:
>> Right, and this would also mean that we silently load vulnerable
>> modules that are linked with either LD that doesn't support
>> --fix-cortex-a53-843419 or simply wasn't passed.
>
> You'll see a warning at least if the linker doesn't support the flag,
> but yes, you're correct. In v1 of this patch set, LTO depended on this
> erratum not being selected, but I changed it in v2 based on Ard's
> suggestion.
>
> I'm fine with not being able to use LTO on devices that are affected
> by this erratum, so either option works for me. I can even change
> this so the user must explicitly disable the erratum in order to use
> LTO. Thoughts?
>

You still have not explained to us how GOLD avoids the erratum.
