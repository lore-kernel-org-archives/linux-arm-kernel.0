From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Apr 2013 16:18:36 +0100
Subject: [PATCH] arm64: remove PSR bit macros from uapi
In-Reply-To: <1365779399-16654-1-git-send-email-ian.campbell@citrix.com>
References: <1365779399-16654-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <20130412151835.GK12363@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Fri, Apr 12, 2013 at 04:09:59PM +0100, Ian Campbell wrote:
> Exposing these in ptrace.h ends up polluting the namespace for user
> applications which include headers such as <signal.h>, e.g. when building Xen
> userspace tools on arm64:
> 
> tools/include/xen/arch-arm.h:229:0: error: "PSR_MODE_EL0t" redefined [-Werror]
> In file included from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/user.h:25:0,
>                  from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/procfs.h:34,
>                  from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/ucontext.h:26,
>                  from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/signal.h:360,
>                  from xentrace.c:21:
> /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/asm/ptrace.h:30:0: note: this is the location of the previous definition

Strange... I don't see the PSR definitions in any headers other than
ptrace.h for my aarch64 toolchain. Which tools are you using?

Will
