From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  3 Dec 2010 18:39:42 +0900
Subject: [PATCH V2 0/2] ARM: SAMSUNG: Add Support Power Domain Control
Message-ID: <1291369184-31460-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support Power Domain Control based on Runtim PM.

Each Power Domain is represented by a Power Domain device and the devices
belong to these Power Domains should be set as a child device of the Power
Domain devices. The corresponding drivers of the devices should implement
Runtime PM to control the Power Domains.

Changes since V1:
- Removed calling of 'samsung_pd_init()' from machine specific code to arch_initcall as Ben's suggestion.
- Use "base" variable in platform data instead of using long switch case statement as Marek's suggestion.
- Add GPS power domain.

[PATCH V2 1/2] ARM: SAMSUNG: Add support for Power Domain control
[PATCH V2 2/2] ARM: S5PV310: Add support Power Domain
