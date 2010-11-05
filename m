From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 05 Nov 2010 00:36:11 +0000
Subject: [PATCH] ARM: fix build error with GCC 4.5.0
References: <1288897002-24073-1-git-send-email-rabin@rab.in>
	<yw1xy698ygbx.fsf@unicorn.mansr.com>
	<19667.9199.798932.405415@pilspetsen.it.uu.se>
Message-ID: <yw1xtyjwy5c4.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> M?ns Rullg?rd writes:
>  > Rabin Vincent <rabin@rab.in> writes:
>  > 
>  > > Fix the following error which occurs when building an ARM kernel with
>  > > GCC 4.5.0:
>  > >
>  > >   kernel/bounds.c:1:0: error: FPA is unsupported in the AAPCS
>  > >
>  > > -CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork
>  > > +CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
>  > 
>  > The real question is why something is trying to use floating-point.
>  > It shouldn't.
>
> Indeed. I suspect an improperly patched or configured gcc-4.5.0,
> or broken kernel sources. Especially considering that the kernel
> passes -msoft-float to gcc (see above).
>
> I know gcc-4.5.0 configured for arm-linux-gnueabi built working EABI
> kernels a few months ago.

FWIW, GCC 4.5.1 built a working ARM kernel for me yesterday.

-- 
M?ns Rullg?rd
mans at mansr.com
