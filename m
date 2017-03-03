From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri, 3 Mar 2017 09:48:52 -0500
Subject: [PATCH 1/3] futex: remove duplicated code
In-Reply-To: <20170303122712.13353-1-jslaby@suse.cz>
References: <20170303122712.13353-1-jslaby@suse.cz>
Message-ID: <8d435487-62a6-ebab-f45f-567d79237e9a@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/3/2017 7:27 AM, Jiri Slaby wrote:
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
> Signed-off-by: Jiri Slaby<jslaby@suse.cz>

Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
