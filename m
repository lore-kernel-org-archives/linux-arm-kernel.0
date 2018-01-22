From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 Jan 2018 15:13:08 -0600
Subject: [RFC PATCH 1/2] arm64: fpsimd: Fix bad si_code for undiagnosed
 SIGFPE
In-Reply-To: <1516623798-25001-2-git-send-email-Dave.Martin@arm.com> (Dave
 Martin's message of "Mon, 22 Jan 2018 12:23:17 +0000")
References: <1516623798-25001-1-git-send-email-Dave.Martin@arm.com>
 <1516623798-25001-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <878tcp8umz.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index e447283..77edb00 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -193,7 +193,8 @@ typedef struct siginfo {
>  #define FPE_FLTRES	6	/* floating point inexact result */
>  #define FPE_FLTINV	7	/* floating point invalid operation */
>  #define FPE_FLTSUB	8	/* subscript out of range */
> -#define NSIGFPE		8
> +#define FPE_UNKNOWN	9	/* undiagnosed floating-point exception */
> +#define NSIGFPE		9

Minor nit here.

At least before this is final I would really appreciate if you could
rebase this on top of my unificiation of siginfo.h that I posted on
linux-arch and is in my siginfo-next branch.

As that already pushes NSIGFPE up to 13.

Which would make this patch change NSIGFPE to 14 and allocate the number
14 for FPE_UNKNOWN

Eric
