From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 08:25:18 -0800
Subject: [PATCH v2 06/18] arm64: kvm: use -fno-jump-tables with clang
In-Reply-To: <20171116114616.GC9361@arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-7-samitolvanen@google.com>
 <20171116114616.GC9361@arm.com>
Message-ID: <20171116162518.GB94341@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:46:17AM +0000, Will Deacon wrote:
> Can you elaborate a bit more on exactly what you saw failing here,
> please?

Mark noticed that clang built kernels fail to boot when the kernel
starts at EL2:

  http://lkml.iu.edu/hypermail/linux/kernel/1711.0/02817.html

Turns out starting with LLVM r308050, the compiler decides to use
a jump table in __init_stage2_translation, and generates code that
branches into an EL1 virtual address.

> Whilst it's obviously broken to jump to EL1 from EL2 w/o VHE, the
> commit message is a bit cryptic.

I agree, I'll add a more descriptive commit message for v3.

Sami
