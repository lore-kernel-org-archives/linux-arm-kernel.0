From: samitolvanen@google.com (Sami Tolvanen)
Date: Mon, 20 Nov 2017 12:51:39 -0800
Subject: [PATCH v2 16/18] arm64: crypto: disable LTO for aes-ce-cipher.c
In-Reply-To: <20171120152014.hftuded4zxwn2r7m@lakrids.cambridge.arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-17-samitolvanen@google.com>
 <20171120152014.hftuded4zxwn2r7m@lakrids.cambridge.arm.com>
Message-ID: <20171120205139.GC89108@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 03:20:14PM +0000, Mark Rutland wrote:
> Could you elaborate on what the integrated asembler doesn't like?

Here's the error, looks like in aes_sub:

<inline asm>:1:69: error: invalid operand for instruction
        dup     v1.4s, w12              ;movi   v0.16b, #0              ;aese   v0.16b, v1.16b          ;umov   w12, v0.4s[0]   ;
                                                                                                                     ^
LLVM ERROR: Error parsing inline asm

Sami
