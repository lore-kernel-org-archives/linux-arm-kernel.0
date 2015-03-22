From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Mar 2015 16:46:22 +0000
Subject: next-20150320 build: 2 failures 25 warnings (next-20150320)
In-Reply-To: <E1YYtMC-00079d-Lq@debutante>
References: <E1YYtMC-00079d-Lq@debutante>
Message-ID: <20150322164622.GK6643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 09:36:44AM +0000, Build bot for Mark Brown wrote:

> 	arm-allmodconfig
> ../fs/btrfs/inode.c:8050:2: error: implicit declaration of function 'iov_iter_alignment' [-Werror=implicit-function-declaration]
> ../fs/btrfs/inode.c:8061:26: error: dereferencing pointer to incomplete type
> ../fs/btrfs/inode.c:8062:29: error: dereferencing pointer to incomplete type
> ../fs/btrfs/inode.c:8063:12: error: dereferencing pointer to incomplete type
> ../fs/btrfs/inode.c:8063:39: error: dereferencing pointer to incomplete type
> ../fs/btrfs/inode.c:8095:2: error: implicit declaration of function 'iov_iter_count' [-Werror=implicit-function-declaration]

For a few days now btrfs has been breaking the ARM allmodconfig build
due to the above errors.  It is relying on the implicit inclusion of
linux/uio.h which isn't getting pulled in on ARM (and possibly some
other architectures too) for the definition of both struct iov_iter and
iov_iter_alignment.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150322/0e740db9/attachment.sig>
