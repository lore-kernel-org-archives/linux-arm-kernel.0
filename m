From: kassey1216@gmail.com (Kassey)
Date: Wed, 30 Aug 2017 16:20:27 +0800
Subject: kasan is not working on 3.18 kernel due to patch "BACKPORT: kernel:
 add kcov code coverage"
Message-ID: <CAKwPUoxHDW4x=uqY5o2rimHDkDPqaN1GdUZ9=eHuP1hwsa7ngw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Dmitry:
    with your change on 3.18 kernel,

     https://github.com/Elite-Kernels/HTC-10/commit/7c8e808c673b50a52e6b5db9bba54678386fa61b

    it was find that cflags for GCC with KASAN enabled is not working.
    testing is doing arm64 platfrom with below configure and gcc 5.1.1

    +CONFIG_KASAN=y
    +CONFIG_TEST_KASAN=m



    and the issue can be fixed by the change, would you please review ?

Author: Kassey <kassey1216@gmail.com>
Date:   Wed Aug 30 15:45:58 2017 +0800

    scripts: correct cflags for kasan

    Signed-off-by: Kassey<kassey1216@gmail.com>

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cea530c..0f1d004 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -125,7 +125,7 @@ endif
 #
 ifeq ($(CONFIG_KASAN),y)
 _c_flags += $(if $(patsubst n%,, \
-
$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)$(CONFIG_KASAN_SANITIZE_ALL)),
\
+               $(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
                $(CFLAGS_KASAN))
 endif



-- 
Best regards
Kassey
