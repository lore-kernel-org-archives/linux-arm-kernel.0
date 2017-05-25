From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 25 May 2017 19:00:51 +0200
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <CAHgaXdKn4J==r_22T3N_7O5oESd8xwL6L+Ot8nT9bGCsSjAkHw@mail.gmail.com>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
 <20170523204608.GG24807@lunn.ch>
 <CAHgaXdJH7VjS__KPOc1scN9d=wxzY0DEQHutiL3qhtQAWd-v-A@mail.gmail.com>
 <20170523232555.GY13759@lunn.ch>
 <CAHgaXdKn4J==r_22T3N_7O5oESd8xwL6L+Ot8nT9bGCsSjAkHw@mail.gmail.com>
Message-ID: <20170525170051.GC18357@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 02:01:36AM +0530, Shubham Bansal wrote:
> Hi Andrew,
> 
> I am attaching the latest patch which should work on ARMv5 , ARMv6 and ARMv7.
> 
> Please test on your machines. Apologies for the last patch. This patch
> should work though.

andrew at shuttle:~/linux$ make -s -j 16
arch/arm/net/bpf_jit_32.c:1755:12: warning: ???validate_code??? defined but not used [-Wunused-function]
 static int validate_code(struct jit_ctx *ctx)
            ^~~~~~~~~~~~~
arch/arm/net/bpf_jit_32.c:1724:12: warning: ???build_body??? defined but not used [-Wunused-function]
 static int build_body(struct jit_ctx *ctx)
            ^~~~~~~~~~
arch/arm/net/bpf_jit_32.c:1122:13: warning: ???build_epilogue??? defined but not used [-Wunused-function]
 static void build_epilogue(struct jit_ctx *ctx)
             ^~~~~~~~~~~~~~
arch/arm/net/bpf_jit_32.c:1049:13: warning: ???build_prologue??? defined but not used [-Wunused-function]
 static void build_prologue(struct jit_ctx *ctx)
             ^~~~~~~~~~~~~~
arch/arm/net/bpf_jit_32.c:174:13: warning: ???jit_fill_hole??? defined but not used [-Wunused-function]
 static void jit_fill_hole(void *area, unsigned int size)
             ^~~~~~~~~~~~~

I _think_ this is because CONFIG_CPU_LITTLE_ENDIAN is not set. But it
is a little endian machine/configuration. ARM does not seem to use
CONFIG_CPU_LITTLE_ENDIAN, it just has CPU_BIG_ENDIAN.

	  Andrew
