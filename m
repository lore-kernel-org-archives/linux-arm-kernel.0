From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Mon, 14 Jul 2014 10:46:05 -0500
Subject: [PATCH 0/2] ARM: minor sigpage enhancements
Message-ID: <1405352767-28768-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Would you consider taking these for 3.17?  I've been carrying the
sigpage placement randomization as part of the VDSO patch set but it
seems worthwhile on its own.  Using _install_special_mapping for the
VDSO and similar VMAs was recently suggested by Andy Lutomirski.

Nathan Lynch (2):
  ARM: use _install_special_mapping for sigpage
  ARM: place sigpage at a random offset above stack

 arch/arm/kernel/process.c | 60 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 9 deletions(-)

-- 
1.9.3
