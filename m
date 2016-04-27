From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 27 Apr 2016 08:22:34 +0200
Subject: [GIT PULL] ARM: EXYNOS: fixes for v4.6
Message-ID: <1461738154-8335-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull one fix for current release.

Best regards,
Krzysztof



The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-4.6

for you to fetch changes up to a0a966b83873f33778710a4fc59240244b0734a5:

  ARM: EXYNOS: Properly skip unitialized parent clock in power domain on (2016-04-25 11:35:37 +0200)

----------------------------------------------------------------
Fix for more theoretical than practical OOPS on first turn on of a exynos
power domain, if there was no turn off before. Usually all power domains
are on, so the first action is to turn off but some older bootloaders
might behave differently.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: EXYNOS: Properly skip unitialized parent clock in power domain on

 arch/arm/mach-exynos/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
