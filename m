From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 29 May 2014 12:53:51 -0400
Subject: nommu build failures on ARM in linux-next
Message-ID: <5387661F.1050000@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

The allnoconfig builds in linux-next fail because __clear_cr
lives in mmu.c without any stub or similar in nommu.c

Introduced by:

commit 247e4fff3aa927ad069447e6da05bb966b70dece
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Apr 13 18:57:29 2014 +0100

    ARM: provide common method to clear bits in CPU control register
    
Sample failure:
  http://kisskb.ellerman.id.au/kisskb/buildresult/11264405/

Paul.
