From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 6 Jul 2015 09:54:08 +0300
Subject: VDSO build failure: collect2: fatal error: cannot find 'ld'
Message-ID: <20150706065408.GI3139@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

In commit log d2b30cd4b722 (ARM: 8384/1: VDSO: force use of BFD linker, 
2015-06-03) you said:

    Note: one limitation of this is that if the toolchain is configured
    to use gold by default, and the bfd linker is not in $PATH, the VDSO
    build will fail:
    
      VDSO    arch/arm/vdso/vdso.so.raw
    collect2: fatal error: cannot find 'ld'
    
    This will happen if CROSS_COMPILE begins with a path such as
    /opt/bin/arm-linux-gnu- but /opt/bin is not in $PATH.  This is
    considered an acceptable corner-case limitation and is easily worked
    around.

I see this build failure here with Sourcery CodeBench Lite 2014.05 even 
though:

	1. This toolchain doesn't include the gold linker at all

	2. I have the arm-2014.05/bin/ directory in my $PATH

	3. My CROSS_COMPILE is set to 'arm-none-linux-gnueabi-'

Reverting d2b30cd4b722 on v4.2-rc1 fixes the build failure.

The Sourcery CodeBench Lite 2014.05 (gcc: 4.8.3, binutils: 2.24.51) is 
available at 
http://sourcery.mentor.com/public/gnu_toolchain/arm-none-linux-gnueabi/arm-2014.05-29-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2

Any hint?

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
