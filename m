From: mkl0301@gmail.com (Lin Mac)
Date: Tue, 9 Nov 2010 15:46:56 +0800
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
Message-ID: <AANLkTinjCNjfRSUaUp=Hu4hD-ri0svM0Mnf8J9R2HB-W@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/5 Lin Mac <mkl0301@gmail.com>:
> 3. How should I debug before start_kernel?
> 9363530 bytes read
> enter do_eth_down!!!
> ## Starting application at 0x04000000 ...
> Uncompressing Li done, booting t
> --
>
> With RVDS, the CPU stops at:
> --
> PC=0x815c
> ...
> 0x815c: E1A00000: MOV r0,r0
> 0x8560: E28F3048: B 0x815c
> ...
> --
> The assembly seems really wrong, but I don't know where is it in the code.
> So I tried to enable DEBUG in head.S with following patch:
> ----
> diff --git a/arch/arm/boot/compressed/head.S
> b/arch/arm/boot/compressed/head.S
> index c5191b1..fbd04c1 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -17,6 +17,7 @@
>   * 100% relocatable.  Any attempt to do so will result in a crash.
>   * Please select one of the following when turning on debugging.
>   */
> +#define DEBUG
>  #ifdef DEBUG
>
>  #if defined(CONFIG_DEBUG_ICEDCC)
> ----
>
> Then it failed at building:
> ----
>   AS      arch/arm/boot/compressed/lib1funcs.o
> arch/arm/boot/compressed/head.S: Assembler messages:
> arch/arm/boot/compressed/head.S:1019: Error: too many positional arguments
> arch/arm/boot/compressed/head.S:1036: Error: too many positional arguments
> make[3]: *** [arch/arm/boot/compressed/head.o] Error 1
> ----
I guess I would need some help in this regard.
Though this issue is solved, but I often get stuck before start_kernel
recently (sigh*) while make some tries. I could do nothing when it
happens. RVDS only provide disassembly, and there is no way for me to
know where the source code the disassembly maps to.

Any tool available for debuging assembly like RVDS do with C?
How can I print some info here? I tried to enable DEBUG in
arch/arm/boot/compressed/head.S but faild.

Really appreciate for any helps.

Best Regards,
Mac Lin
