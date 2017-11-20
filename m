From: samitolvanen@google.com (Sami Tolvanen)
Date: Mon, 20 Nov 2017 13:01:43 -0800
Subject: [PATCH v2 16/18] arm64: crypto: disable LTO for aes-ce-cipher.c
In-Reply-To: <CAKv+Gu-hnoeLqNsHbrLXv3xu7qsYB6REiwMtQYW_0CPwZ7jF4g@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-17-samitolvanen@google.com>
 <20171120152014.hftuded4zxwn2r7m@lakrids.cambridge.arm.com>
 <CAKv+Gu-hnoeLqNsHbrLXv3xu7qsYB6REiwMtQYW_0CPwZ7jF4g@mail.gmail.com>
Message-ID: <20171120210143.GD89108@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 03:25:31PM +0000, Ard Biesheuvel wrote:
> However, under LTO this all changes, and it is no longer guaranteed
> that the NEON registers are only touched between the kernel mode
> neon begin/end calls.

LTO operates on LLVM IR, so disabling LTO for this file should make
sure there won't be any unsafe optimizations. Are there other places
in the kernel that might have this issue?

> So the correct way to fix this would be to move the asm into its own
> .S file, and call it from between the kernel_mode_neon_begin/end
> calls. That should also fix your compat issue.

Sure, that would also work.
 
Sami
