From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Fri, 3 Mar 2017 15:08:37 +0100
Subject: [PATCH 1/3] futex: remove duplicated code
In-Reply-To: <20170303122712.13353-1-jslaby@suse.cz>
References: <20170303122712.13353-1-jslaby@suse.cz>
Message-ID: <20170303140837.GF5319@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 01:27:10PM +0100, Jiri Slaby wrote:
> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
> 
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.
> 
> Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> remove pointless access_ok() checks") as access_ok there returns true.
> We introduce it back to the helper for the sake of simplicity (it gets
> optimized away anyway).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  arch/s390/include/asm/futex.h       | 23 ++++-------------
>  include/asm-generic/futex.h         | 50 +++++++------------------------------
>  kernel/futex.c                      | 36 ++++++++++++++++++++++++++

Looks good to me and still boots on s390. Therefore for the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks!
