From: ldv@altlinux.org (Dmitry V. Levin)
Date: Wed, 9 Aug 2017 01:57:39 +0300
Subject: [PATCH v06 14/36] arm uapi asm/signal.h: include <stddef.h> for
 size_t in userspace
In-Reply-To: <20170806164428.2273-15-mikko.rapeli@iki.fi>
References: <20170806164428.2273-1-mikko.rapeli@iki.fi>
 <20170806164428.2273-15-mikko.rapeli@iki.fi>
Message-ID: <20170808225739.GF10552@altlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 06, 2017 at 06:44:05PM +0200, Mikko Rapeli wrote:
> Arnd Bergmann <arnd@arndb.de> doubts that __kernel_size_t could be used here
> so trying to fall back to gcc's <stddef.h>.

The only architecture where you cannot do this safely is x86 family
because of x32 exception.  If there is no chance that the change will
affect x32, feel free to replace size_t with __kernel_size_t like I did
some time ago, see
http://lkml.kernel.org/r/20170302002022.GB27097 at altlinux.org


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170809/e5fabc5a/attachment.sig>
