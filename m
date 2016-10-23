From: vgupta@synopsys.com (Vineet Gupta)
Date: Sun, 23 Oct 2016 13:57:27 -0700
Subject: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
In-Reply-To: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <4e1a4e68-5c84-ce9d-73df-b7da312cc884@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2016 05:14 AM, Yury Norov wrote:
> The newer prlimit64 syscall provides all the functionality provided by
> the getrlimit and setrlimit syscalls and adds the pid of target process,
> so future architectures won't need to include getrlimit and setrlimit.
>
> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> unistd.h prior to including asm-generic/unistd.h, and adjust all
> architectures using the generic syscall list to define it so that no
> in-tree architectures are affected.
>
> Cc: Vineet Gupta <vgupta@synopsys.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com> #arch/arc bits

Thx,
-Vineet
