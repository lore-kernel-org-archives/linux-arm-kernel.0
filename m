From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 1 Jun 2016 11:05:58 +0800
Subject: [RFC PATCH 0/4] arm64: vdso: check whether the params is invalid
 address
Message-ID: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The params of gettimeofday(), clock_gettime() and clock_getres()
is not checked. This will cause segment faults when the address is
invalid. 
E.g. gettimeofday(-1, -1);
     clock_gettime(0, -1);
     clock_getres(0, -1);
This patchset add a macro and use it to check the validation of these
pointer params.


Yang Yingliang (4):
  arm64: vdso: introdce a macro for checking the address
  arm64: vdso: check whether the params of gettimeofday() is valid
  arm64: vdso: check whether the tp pointer is valid in clock_gettime()
  arm64: vdso: check whether the res pointer is valid in clock_getres()

 arch/arm64/kernel/asm-offsets.c       |  3 ++
 arch/arm64/kernel/vdso/gettimeofday.S | 71 +++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.5.0
