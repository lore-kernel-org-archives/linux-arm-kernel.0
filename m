From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Wed, 28 Jul 2010 12:45:44 +0200
Subject: Questions about FPU and NEON on Cortex-A9 with armv7 instructions!
In-Reply-To: <AANLkTinoZ0GT5FFUFPmU5gQK1zVcZKYtSWpHDQ1Y4OXO@mail.gmail.com>
References: <AANLkTinA_ZNdNwx2R-6C9LBQ=4i8uMVpmVFCRaKkS=Xs@mail.gmail.com>	<AANLkTi=EBvumJfRJmBwHVtHAW081ewBzjAR2d=2O2-Zd@mail.gmail.com>	<AANLkTikHns6tdbVK-CDoiv10V-pHaYFf0AvB5s=ti9k5@mail.gmail.com>	<4C4FF8FF.304@xenomai.org>
	<AANLkTinoZ0GT5FFUFPmU5gQK1zVcZKYtSWpHDQ1Y4OXO@mail.gmail.com>
Message-ID: <4C500A58.4000400@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Yang wrote:
> My God...
> 
> The job for the FPU is big enough.
> 
> But I am not sure the kernel itself won't use the FPU .

Of that you are sure: on ARM, the kernel does not use the FPU.

 And I just
> want to use FPU in my driver other than the whole kernel.
> 
> If the other kernel code doesn't save and restore the FPU context,then
> it's risky.
> 
> Can I use FPU just in one C file ?

Apparently, I could not make myself clear. So, looking at the code will
probably help you understand better.
drivers/md/raid6mmx.c and arch/x86/lib/mmx_32.c use fpu in kernel-space.
You just have to do it the same way.


-- 
					    Gilles.
