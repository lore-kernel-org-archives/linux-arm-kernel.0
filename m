From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Thu, 29 Sep 2011 08:30:01 -0400
Subject: [PATCH] PM: HIBERNATION: add resume_wait param to support
	MMC-like devices as resume file
In-Reply-To: Your message of "Thu, 29 Sep 2011 02:29:08 PDT."
	<1317288548-19560-1-git-send-email-Barry.Song@csr.com>
References: <1317288548-19560-1-git-send-email-Barry.Song@csr.com>
Message-ID: <59872.1317299401@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Sep 2011 02:29:08 PDT, Barry Song said:

> This patch adds resumewait kernel param just like rootwait so
> that we have enough time to wait mmc ready. The differene is
> here we wait for resume partition but rootwait waits for rootfs
> partition.

OK, seems a reasonable idea...

> kernel/power/hibernate.c |   16 ++++++++++++++++
> 1 files changed, 16 insertions(+), 0 deletions(-)

We have a __setup() parameter, this patch appears to be missing
a hunk for Documentation/kernel-parameters.txt?

Fix that issue, and you can stick this on there:

Reviewed-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110929/d6c2e289/attachment.sig>
