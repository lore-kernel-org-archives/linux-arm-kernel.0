From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 26 Nov 2015 10:14:02 +0200
Subject: [PATCH] remoteproc: avoid stack overflow in debugfs file
In-Reply-To: <10169860.4GdufNCNz1@wuerfel>
References: <10169860.4GdufNCNz1@wuerfel>
Message-ID: <CAK=WgbYafpVNBoCtsOBfuMn9OqBW_RP9=2Px8q-homVXLGQUpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 7:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Recent gcc versions warn about reading from a negative offset of
> an on-stack array:
>
> drivers/remoteproc/remoteproc_debugfs.c: In function 'rproc_recovery_write':
> drivers/remoteproc/remoteproc_debugfs.c:167:9: warning: 'buf[4294967295u]' may be used uninitialized in this function [-Wmaybe-uninitialized]
>
> I don't see anything in sys_write() that prevents us from
> being called with a zero 'count' argument, so we should
> add an extra check in rproc_recovery_write() to prevent the
> access and avoid the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2e37abb89a2e ("remoteproc: create a 'recovery' debugfs entry")

Applied to remoteproc-fixes, thanks.
