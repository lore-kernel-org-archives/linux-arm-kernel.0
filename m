From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri, 3 Nov 2017 11:22:06 -0700
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
Message-ID: <20171103182206.GA117212@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 05:51:56PM +0000, Mark Rutland wrote:
> Which tree are you testing with?

I've tested that this builds on top of Linus' current tree.

> I had to create an aarch64-linux-gnu-clang wrapper, too. I'm not sure if
> there's build system help to avoid needing that?

This appears to depend on how your toolchain was built as Nick mentioned in
an earlier message. I compiled clang from the unified LLVM git repo using
this configuration:

  $ make -G Ninja ../llvm-project/llvm \
	-DCMAKE_BUILD_TYPE=Release \
	-DENABLE_PIC=1 \
	-DLLVM_BINUTILS_INCDIR=/path/to/binutils-2.27/include \
	-DLLVM_TARGETS_TO_BUILD="X86;AArch64" && \
    ninja

Sami
