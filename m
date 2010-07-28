From: martinwguy@gmail.com (Martin Guy)
Date: Wed, 28 Jul 2010 09:57:43 +0100
Subject: Questions about FPU and NEON on Cortex-A9 with armv7
	instructions!
In-Reply-To: <AANLkTinA_ZNdNwx2R-6C9LBQ=4i8uMVpmVFCRaKkS=Xs@mail.gmail.com>
References: <AANLkTinA_ZNdNwx2R-6C9LBQ=4i8uMVpmVFCRaKkS=Xs@mail.gmail.com>
Message-ID: <AANLkTi=EBvumJfRJmBwHVtHAW081ewBzjAR2d=2O2-Zd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/28/10, David Yang <david.yangshuai@gmail.com> wrote:
>        Because I need use the NEON on Cortex-A9, so I want to add the
>  parameter : -mfpu=neon -mfloat-abi=softfp to the KBUILD_CFLAGS and
>  KBUILD_AFLAGS in the Makefile of the top dir like below:

Hi David
   Linux never uses the FPU internally, in fact it doesn't use
floating point at all. Linux's task with the FPU is only to initialize
it so that user-space applications can use it, and to save/restore FP
register contents when two processes are both using it.
   In the kernel itself only integer math is used.

Cheers

    M
