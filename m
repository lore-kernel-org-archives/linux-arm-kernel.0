From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sat, 24 Mar 2012 14:26:12 +0400
Subject: [PATCH v2 0/10] Fixes for common mistakes w/ for_each_process and
 task->mm
Message-ID: <20120324102609.GA28356@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a reincarnation of the task->mm fixes. Several architectures
were traverse the tasklist in an unsafe manner, plus there are a
few cases of unsafe access to task->mm.

In v2 I decided to introduce a small helper in cpu.c: most arches
duplicate the same [buggy] code snippet, so it's better to fix it
and move the logic into a common function.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
