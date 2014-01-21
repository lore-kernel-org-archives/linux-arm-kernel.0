From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 21 Jan 2014 21:58:41 +0200
Subject: ARM kernel (& ext3) stability issues with GCC 4.8?
In-Reply-To: <20130613220429.GC18360@blackmetal.musicnaut.iki.fi>
References: <20130613220429.GC18360@blackmetal.musicnaut.iki.fi>
Message-ID: <20140121195841.GA23238@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 14, 2013 at 01:04:29AM +0300, Aaro Koskinen wrote:
> I'm having severe stability issues with 3.10-rc5 on OpenRD (kirkwood)
> when cross-compiling it using GCC 4.8.1 (I tried also GCC 4.8.0
> with 3.9-something earlier with pretty much same results).
[...]
> [ 3383.627778] ------------[ cut here ]------------
> [ 3383.654029] kernel BUG at fs/buffer.c:2956!

It looks like the issue was caused by GCC bug 58854
(http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854).

The bug is still present in GCC 4.8.2 but there's a fix available in GCC
repository. The bug resulted in at least fs/buffer.c getting compiled
incorrectly, and what we saw were kernel crashes or file system getting
corrupted or both.

A.
