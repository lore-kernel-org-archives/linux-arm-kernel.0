From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 08:43:06 -0800
Subject: [PATCH v2 11/18] arm64: make mrs_s and msr_s macros work with LTO
In-Reply-To: <20171116115433.GG9361@arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-12-samitolvanen@google.com>
 <20171116115433.GG9361@arm.com>
Message-ID: <20171116164306.GF94341@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:54:33AM +0000, Will Deacon wrote:
> What limitations? Can you elaborate please? Is this a fix?

The commit message in v1 was more informative, I'll change this back for v3:

--

Clang's integrated assembler does not allow assembly macros defined
in one inline asm block using the .macro directive to be used across
separate asm blocks. LLVM developers consider this a feature and not a
bug, recommending code refactoring:

https://bugs.llvm.org/show_bug.cgi?id=19749

As binutils doesn't allow macros to be redefined, this change adds C
preprocessor macros that define the assembly macros globally for binutils
and locally for clang's integrated assembler.

Sami
