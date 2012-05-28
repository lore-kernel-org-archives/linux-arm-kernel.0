From: vincent.sanders@collabora.co.uk (Vincent Sanders)
Date: Mon, 28 May 2012 19:33:36 +0100
Subject: Add gcov support to ARM
Message-ID: <1338230018-31052-1-git-send-email-vincent.sanders@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches add the necessary support for gcov on ARM. The idea
is based on an original patch in 2010 by George G. Davis
<gdavis@mvista.com> but re-implemented against 3.4.

The approach requires the constructor symbol name be adjusted as it is
different on ARM to other platforms (I have directly tested on x86 and
arm). Currently I cannot find another platform where the symbol name
is not .ctors but it can be readily added.

Once the constructors are called correctly the actual changes to the
ARM architecture is minimal and principally involves avoiding adding
gcov compilation options to the early boot code.
