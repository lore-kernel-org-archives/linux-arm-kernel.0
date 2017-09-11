From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 11 Sep 2017 09:21:36 -0700
Subject: resend: [PATCH 0/3] arm+arm64: vdso: Unification
Message-ID: <20170911162138.113579-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. Make sure it will work for future Aarch32 vdso
on arm64.

Side effects include renaming some vdso_datapage.h variables, adding
a few more to enhance features and functionality to match.

Finally, add unified support for CLOCK_BOOTTIME in clock_gettime call.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
