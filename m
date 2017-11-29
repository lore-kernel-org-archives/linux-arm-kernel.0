From: ndesaulniers@google.com (Nick Desaulniers)
Date: Wed, 29 Nov 2017 09:39:28 -0800
Subject: [PATCH 1/3] kbuild: add clang-version.sh
In-Reply-To: <20171129000011.55235-2-samitolvanen@google.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
 <20171129000011.55235-2-samitolvanen@google.com>
Message-ID: <CAKwvOdndEfdXuRCeSsr04pAt0d0tE_z72DUYc2Z9LCnXAQc4Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+# clang-version [-p] clang-command
+#
+# Prints the compiler version of `command' in a canonical 4-digit form

small nit: `command` should be `clang-command`, but its just a comment
(maybe the maintainer can make that change when/if applying).

The conditional at the end to see if $with_patchlevel using "x" is
odd, but this is what scripts/gcc-version.sh does and this patch does
work as expected.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
