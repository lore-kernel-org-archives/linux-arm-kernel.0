From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jan 2017 16:10:55 +0000
Subject: [PATCH 0/3] arm64: {adr,ldr}_l cleanup
Message-ID: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While looking at the way we use adrp, I spotted that there are still a few
open-coded instances of adr_l and ldr_l.

These patches clean those up, making the code a little easier to follow.

Thanks,
Mark.

Mark Rutland (3):
  arm64: head.S: avoid open-coded adr_l
  arm64: efi-entry.S: avoid open-coded adr_l
  arm64: entry-ftrace.S: avoid open-coded {adr,ldr}_l

 arch/arm64/kernel/efi-entry.S    |  9 +++------
 arch/arm64/kernel/entry-ftrace.S | 12 ++++--------
 arch/arm64/kernel/head.S         |  3 +--
 3 files changed, 8 insertions(+), 16 deletions(-)

-- 
1.9.1
