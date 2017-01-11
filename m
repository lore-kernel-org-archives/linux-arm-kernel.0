From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed, 11 Jan 2017 16:28:38 +0000
Subject: [kvm-unit-tests PATCH 3/6] docs: move README to README.md and symlink
In-Reply-To: <20170111162841.15569-1-alex.bennee@linaro.org>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
Message-ID: <20170111162841.15569-4-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows a slightly nicer formatting of the text when displayed on
some repository hosts. We keep a symlink from README for the
old-school purists.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 README    | 69 +----------------------------------------------------
 README.md | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 68 deletions(-)
 mode change 100644 => 120000 README
 create mode 100644 README.md

diff --git a/README b/README
deleted file mode 100644
index f8f196d..0000000
--- a/README
+++ /dev/null
@@ -1,68 +0,0 @@
-Welcome to kvm-unit-tests
-
-See http://www.linux-kvm.org/page/KVM-unit-tests for a high-level
-description of this project, as well as running tests and adding
-tests HOWTOs.
-
-This directory contains sources for a kvm test suite.
-
-To create the test images do
-  ./configure
-  make
-in this directory. Test images are created in ./<ARCH>/*.flat
-
-Then use the runner script to detect the correct invocation and
-invoke the test, e.g.
-  ./x86-run ./x86/msr.flat
-or
-  ./run_tests.sh
-to run them all.
-
-To select a specific qemu binary, specify the QEMU=<path>
-environment variable, e.g.
-  QEMU=/tmp/qemu/x86_64-softmmu/qemu-system-x86_64 ./x86-run ./x86/msr.flat
-
-To create and use standalone tests do
-  ./configure
-  make standalone
-  (send tests/some-test somewhere)
-  (go to somewhere)
-  ./some-test
-
-'make install' will install all tests in PREFIX/share/kvm-unit-tests/tests,
-each as a standalone test.
-
-Directory structure:
-.:		configure script, top-level Makefile, and run_tests.sh
-./scripts:	helper scripts for building and running tests
-./lib:		general architecture neutral services for the tests
-./lib/<ARCH>:	architecture dependent services for the tests
-./<ARCH>:	the sources of the tests and the created objects/images
-
-See <ARCH>/README for architecture specific documentation.
-
-CONTRIBUTING:
-=============
-
-Style
------
-
-Currently there is a mix of indentation styles so any changes to
-existing files should be consistent with the existing style. For new
-files:
-
-  - C: please use standard linux-with-tabs
-  - Shell: use TABs for indentation
-
-Patches
--------
-
-Patches are welcome at the KVM mailing list <kvm@vger.kernel.org>.
-
-Please prefix messages with: [kvm-unit-tests PATCH]
-
-You can add the following to .git/config to do this automatically for you:
-
-[format]
-	subjectprefix = kvm-unit-tests PATCH
-
diff --git a/README b/README
new file mode 120000
index 0000000..42061c0
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+README.md
\ No newline at end of file
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..5027b62
--- /dev/null
+++ b/README.md
@@ -0,0 +1,81 @@
+# Welcome to kvm-unit-tests
+
+See http://www.linux-kvm.org/page/KVM-unit-tests for a high-level
+description of this project, as well as running tests and adding
+tests HOWTOs.
+
+# Building the tests
+
+This directory contains sources for a kvm test suite.
+
+To create the test images do:
+
+    ./configure
+    make
+
+in this directory. Test images are created in ./<ARCH>/*.flat
+
+## Standalone tests
+
+The tests can be built as standalone
+To create and use standalone tests do:
+
+    ./configure
+    make standalone
+    (send tests/some-test somewhere)
+    (go to somewhere)
+    ./some-test
+
+'make install' will install all tests in PREFIX/share/kvm-unit-tests/tests,
+each as a standalone test.
+
+
+# Running the tests
+
+Then use the runner script to detect the correct invocation and
+invoke the test:
+
+    ./x86-run ./x86/msr.flat
+or:
+
+    ./run_tests.sh
+
+to run them all.
+
+To select a specific qemu binary, specify the QEMU=<path>
+environment variable:
+
+    QEMU=/tmp/qemu/x86_64-softmmu/qemu-system-x86_64 ./x86-run ./x86/msr.flat
+
+# Contributing
+
+## Directory structure
+
+    .:				configure script, top-level Makefile, and run_tests.sh
+    ./scripts:		helper scripts for building and running tests
+    ./lib:			general architecture neutral services for the tests
+    ./lib/<ARCH>:	architecture dependent services for the tests
+    ./<ARCH>:		the sources of the tests and the created objects/images
+
+See <ARCH>/README for architecture specific documentation.
+
+## Style
+
+Currently there is a mix of indentation styles so any changes to
+existing files should be consistent with the existing style. For new
+files:
+
+  - C: please use standard linux-with-tabs
+  - Shell: use TABs for indentation
+
+## Patches
+
+Patches are welcome at the KVM mailing list <kvm@vger.kernel.org>.
+
+Please prefix messages with: [kvm-unit-tests PATCH]
+
+You can add the following to .git/config to do this automatically for you:
+
+    [format]
+        subjectprefix = kvm-unit-tests PATCH
+
-- 
2.11.0
