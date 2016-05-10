From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 May 2016 09:27:29 +0200
Subject: [GIT PULL] at91: fixes for 4.6 #1
Message-ID: <1462865249-28552-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here is a late fix for AT91. Sorry to have figure it out so late in the
development cycle but we had to confirm it was an error with the documentation
of two products.
So, as the compatibility string is in since 4.6-rc1 and that the previous one
works okay, it's a good opportunity to switch back to the one that works without
introducing a intermediary bug.
The revert on driver code and the removal of the useless additional
compatibility string will be queued for 4.7 through NAND/MTD.

Thanks, best regards,

The following changes since commit 02da2d72174c61988eb4456b53f405e3ebdebce4:

  Linux 4.6-rc5 (2016-04-24 16:17:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to b8453d4ee9e24c6590dd0eecbab1c3cc2028317f:

  ARM: dts: at91: sama5d2: use "atmel,sama5d3-nfc" compatible for nfc (2016-05-10 09:09:47 +0200)

----------------------------------------------------------------
One fix for 4.6:
- error in the documentation led to wrongly add a new NAND Flash Controller
  type. Switch back to the previous compatible one.

----------------------------------------------------------------
Wenyou Yang (1):
      ARM: dts: at91: sama5d2: use "atmel,sama5d3-nfc" compatible for nfc

 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Nicolas Ferre
