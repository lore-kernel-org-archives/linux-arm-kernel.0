From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 9 Feb 2017 18:29:15 +0800
Subject: Aarch64 kernel with 32bit userspace question
In-Reply-To: <0057242a-2e16-3b59-1f81-9f4ccf64216d@denx.de>
References: <0057242a-2e16-3b59-1f81-9f4ccf64216d@denx.de>
Message-ID: <20170209182915.6d909f3f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Feb 2017 11:14:19 +0100
Marek Vasut <marex@denx.de> wrote:

> Hi,
> 
> I'm trying multilib userland on aarch64, but I'm running into a problem.
> I have a simple test code:
> 
> -->8--  
> #include <signal.h>
> 
> int main(void) {
>     return 0;
> }
> --8<--
> 
> If I compile that with aarch64 gcc , it compiles just fine.
> 
> If I compile the same thing with 32bit armv7ahf multilib gcc, the
> build fails on "unknown type name '__uint128_t'". This comes from
> arch/arm64/include/uapi/asm/sigcontext.h , which has __uint128_t in
> struct fpsimd_context {} . The signal.h includes that (through a few
> glibc headers) and that's what triggers the failure. __uint128_t is
> defined on aarch64 , but it is not on armv7a (32bit).
> 

which 32bit toolchain are you using?

I didn't see any problems with 32bit armhf linaro toolchain, or the
toolchain in debian armhf or ubuntu
