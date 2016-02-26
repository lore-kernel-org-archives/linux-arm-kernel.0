From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Fri, 26 Feb 2016 08:44:11 -0500
Subject: [PATCH, RESEND] xen: allocate gntdev_copy_batch dynamically
In-Reply-To: <1456435523-287763-1-git-send-email-arnd@arndb.de>
References: <1456435523-287763-1-git-send-email-arnd@arndb.de>
Message-ID: <56D056AB.4020806@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2016 04:25 PM, Arnd Bergmann wrote:
> struct gntdev_copy_batch is arguably too large to fit on the kernel stack,
> and we get a warning about the stack usage in gntdev_ioctl_grant_copy:
>
> drivers/xen/gntdev.c:949:1: error: the frame size of 1240 bytes is larger than 1024 bytes
>
> This changes the code to us a dynamic allocation instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a4cdb556cae0 ("xen/gntdev: add ioctl for grant copy")
> ---
>   drivers/xen/gntdev.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> I sent this in January, Boris sent an almost identical patch
> as http://www.gossamer-threads.com/lists/xen/devel/414056
> but the bug remains present in mainline and linux-next as of
> Feb 25.
>
> Could you apply one of the patches before the bug makes it
> into v4.5?

David wanted to shrink the structure size instead:
     http://www.gossamer-threads.com/lists/xen/devel/414535

-boris
