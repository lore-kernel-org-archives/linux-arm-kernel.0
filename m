From: mikpe@it.uu.se (Mikael Pettersson)
Date: Thu, 15 Aug 2013 16:32:00 +0200
Subject: [PATCH] ARM: add workaround for ambiguous C99 stdint.h types
In-Reply-To: <1376570746-18831-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1376570746-18831-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <21004.58976.848644.601278@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel writes:
 > The C99 types uintXX_t that are usually defined in 'stdint.h' are not as
 > unambiguous on ARM as you would expect. For the types below, there is a
 > difference on ARM between GCC built for bare metal ARM, GCC built for glibc
 > and the kernel itself, which results in build errors if you try to build with
 > -ffreestanding and include 'stdint.h' (such as when you include 'arm_neon.h'
 > in order to use NEON intrinsics)

What exactly is the failure?  Can you show us a test case?
