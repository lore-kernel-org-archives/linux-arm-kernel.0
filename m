From: qiaozhou@asrmicro.com (Qiao Zhou)
Date: Wed, 28 Jun 2017 17:04:11 +0800
Subject: [PATCH] *** arm64: traps: disable irq in die() ***
Message-ID: <1498640652-23338-1-git-send-email-qiaozhou@asrmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I met several cases that die() is interrupted once irq is unlocked, on
our platform which has multiple cpus, and enables panic_on_oops. It deadlock
in some schedule related code, and hard-lockup is triggered. So the first
criminal field is gone.

So I want to protect the whole flow of die() from irq, and let the panic
flow execute correctly. Not sure this patch is suitable or there is better
way to solve it. Please help to give some comments. Thanks in advance.

Qiao Zhou (1):
  arm64: traps: disable irq in die()

 arch/arm64/kernel/traps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.7.4
