From: ndesaulniers@google.com (Nick Desaulniers)
Date: Fri, 3 Nov 2017 11:20:11 -0700
Subject: [PATCH 07/15] arm64: use -mno-implicit-float instead of
 -mgeneral-regs-only
In-Reply-To: <20171103180257.e52r2qdeeg4m4l5p@lakrids.cambridge.arm.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-9-samitolvanen@google.com>
 <20171103180257.e52r2qdeeg4m4l5p@lakrids.cambridge.arm.com>
Message-ID: <CAKwvOdna0oZGj6QySaALEJ_y1s5QW-mBLMsxoJs4T-qLzeFnFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 11:02 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Ah, so I guess this is what I was hitting when testing with clang 5.0.0.

Exactly.

> I was under the impression that this series was jsut enablnig LTO
> support, not clang support generally.

Clang is supported at least for the arm64*/x86-64 configs that we've
gotten around to testing.

* minus this one last compiler bug (but maybe "last" is optimistic).

> It would be much nicer if we could depend on a fixed clang to start
> with...

I agree, which is why I'm on the fence with this patch.  With a newer
version of Clang, it's not needed.

There are some kbuild macros for certain versions of GCC, maybe
something like that can be used to conditionally swap these flags if
using an older version of Clang?

>> +# This is a workaround for https://bugs.llvm.org/show_bug.cgi?id=30792.
>> +KBUILD_CFLAGS        += -mno-implicit-float
>> +else
>> +KBUILD_CFLAGS        += -mgeneral-regs-only
>> +endif
