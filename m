From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 Feb 2018 17:31:38 +0000
Subject: [PATCH 0/2] Apply BP hardening for IRQs, PC alignment and Debug faults
Message-ID: <1517592700-26497-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Please can you include these two in your BP hardening series? Dan pointed
out that there are a few exception types that could come in before the
instruction abort, so we need to make sure we catch them too.

Cheers,

Will

--->8

Will Deacon (2):
  arm64: entry: Apply BP hardening for high-priority synchronous
    exceptions
  arm64: entry: Apply BP hardening for suspicious interrupts from EL0

 arch/arm64/kernel/entry.S | 10 +++++++++-
 arch/arm64/mm/fault.c     | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.1.4
