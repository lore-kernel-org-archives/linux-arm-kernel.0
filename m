From: tj@kernel.org (Tejun Heo)
Date: Thu, 15 Oct 2015 11:11:52 -0400
Subject: [PATCH] ahci: qoriq: Fix a compiling warning
In-Reply-To: <1444812412-33321-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1444812412-33321-1-git-send-email-Yuantian.Tang@freescale.com>
Message-ID: <20151015151152.GB27717@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 14, 2015 at 04:46:52PM +0800, Tang Yuantian wrote:
> kbuild test robot reports the warnings:
> drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> >> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
> >> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
> 
> This patch fixed it by introducing a local variable.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hmmm... why is the patch signed off by Arnd?  You can't sign off for
other people.  If this was suggested by Arnd, please use
"Suggested-by:" or "Original-patch-by:".

Thanks.

-- 
tejun
