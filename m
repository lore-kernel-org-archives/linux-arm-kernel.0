From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Nov 2010 14:32:30 +0000
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
Message-ID: <20101112143230.GA8197@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 11:08:25AM +0800, Lin Mac wrote:
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

Please do:

make ARCH=arm CROSS_COMPILE=... arch/arm/boot/compressed/head.s

and send me (in private mail) a copy of head.s.  Thanks.
