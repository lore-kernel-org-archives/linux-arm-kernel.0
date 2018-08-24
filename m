From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Aug 2018 15:08:28 +0100
Subject: [PATCH 0/2] arm/arm64: smccc-1.1 fixes
Message-ID: <20180824140830.12747-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Julien Grall recently reported that our smccc-1.1 helpers suffer from
a couple of glaring problems:

- the return values are not necessarily of the same type as the input,
  and we may end-up truncating them

- the macros are not safe in the presence of function calls passed as
  parameters.

These two patches are trying to handle that. Note that the current use
of these macros in the kernel is safe, so this is not an urgent fix.

Marc Zyngier (2):
  arm/arm64: smccc-1.1: Make return values unsigned long
  arm/arm64: amccc-1.1: Handle function result as parameters

 include/linux/arm-smccc.h | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

-- 
2.18.0
