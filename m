From: geoff@infradead.org (Geoff Levand)
Date: Wed, 06 Jul 2016 10:44:27 -0700
Subject: [PATCH v21 7/8] arm64: kdump: update a kernel doc
In-Reply-To: <20160706075226.27609-8-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-8-takahiro.akashi@linaro.org>
Message-ID: <1467827067.8880.43.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
>  a remote system.
>  
>  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> -s390x and arm architectures.
> +s390x, arm and arm64 architectures.
>  
>  When the system kernel boots, it reserves a small section of memory for
>  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> @@ -249,6 +249,13 @@ Dump-capture kernel config options (Arch Dependent, arm)
>  
>      AUTO_ZRELADDR=y
>  
> +Dump-capture kernel config options (Arch Dependent, arm64)
> +----------------------------------------------------------
> +
> +- Please note that kvm at the dump-capture kernel will not be enabled

kvm of the dump-capture kernel

> +  on non-VHE system even if it is configured. This is because we have

on non-VHE systems

> +  no chance to reset CPU state to EL2 on panic.

This is because the CPU state cannot be reset to EL2 on panic.
