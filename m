From: achandran@mvista.com (Arun Chandran)
Date: Thu, 26 Jun 2014 11:33:48 +0530
Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
In-Reply-To: <1403724500.11749.22.camel@smoke>
References: <53AAE632.3020806@mvista.com>
	<1403724500.11749.22.camel@smoke>
Message-ID: <CAFdej01izSoBYTqd6dkSfE7eq4WcUTzePZFOJZLMT=VEne3+pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,


>
> On Wed, 2014-06-25 at 20:39 +0530, arun chandran wrote:
> > Selecting CPU_BIG_ENDIAN and building the kernel fails just after
> > building it for little endian with the message
> >
> >    VDSOA arch/arm64/kernel/vdso/gettimeofday.o
> >    VDSOL arch/arm64/kernel/vdso/vdso.so.dbg
> > /gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
> > arch/arm64/kernel/vdso/note.o: compiled for a little endian system and
> > target is big endian
> > /gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
> > failed to merge target specific data of file
> > arch/arm64/kernel/vdso/note.o
> > /gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
> > arch/arm64/kernel/vdso/sigreturn.o: compiled for a little endian system
> > and target is big endian
> > /gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
> > failed to merge target specific data of file
> > arch/arm64/kernel/vdso/sigreturn.o
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [arch/arm64/kernel/vdso/vdso.so.dbg] Error 1
> > make[1]: *** [arch/arm64/kernel/vdso] Error 2
> > make: *** [arch/arm64/kernel] Error 2
> > make: *** Waiting for unfinished jobs....
> >
> > Fix it by 'Forcing' the build in arch/arm64/kernel/vdso/Makefile
> >
> > Signed-off-by: Arun Chandran <achandran@mvista.com>
>
> This seems like a bit too much to put into the commit log.  What about
> something like:
>
>   Selecting CPU_BIG_ENDIAN and building the kernel fails just after
>   building it for little endian.  Fix it by 'Forcing' the build of
>   vdso.  Fixes build errors like these:
>
>     arch/arm64/kernel/vdso/note.o: compiled for a little endian system and target is big endian
>
Ok I will do that and resend it.

--Arun
