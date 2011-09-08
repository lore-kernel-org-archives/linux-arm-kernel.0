From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  8 Sep 2011 17:04:11 +0100
Subject: [PATCH v2 0/3] ARM: iwmmxt/pj4 fixes for v7/Thumb-2
Message-ID: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iwmmxt and pj4 support code contains some code which isn't
compatible with Thumb-2 and looks possibly inappropriate for v7.

There is also an issue with Makefile rules causing iwmmxt.S to be
built for the wrong architecture.

The Makefile and .S changes for iwmmxt may get folded into a
single patch; they don't make much sense independently any more.

v2 changes:

*   Makefile logic changed, so that -march=armv7-a+iwmmxt is
    demanded for Thumb-2 kernels, and a warning is printed if the
    assembler doesn't support this when buiding a v7 ARM kernel.

Dave Martin (3):
  ARM: iwmmxt: Fix Makefile rules for building iwmmxt for Thumb-2
  ARM: iwmmxt: Port problematic iwmmxt support code to v7/Thumb-2
  ARM: pxa/pj4: Port problematic pj4 support code to v7/Thumb-2

 arch/arm/kernel/Makefile  |   12 ++++++++++++
 arch/arm/kernel/iwmmxt.S  |    9 +++++++++
 arch/arm/kernel/pj4-cp0.c |    4 ++++
 3 files changed, 25 insertions(+), 0 deletions(-)

--
1.7.4.1
