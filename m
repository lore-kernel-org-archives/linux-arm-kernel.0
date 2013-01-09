From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 11:52:29 +0000
Subject: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <20130109111055.GG3931@n2100.arm.linux.org.uk>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <20130109104414.GF3931@n2100.arm.linux.org.uk>
 <20130109111055.GG3931@n2100.arm.linux.org.uk>
Message-ID: <201301091152.30047.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Russell King - ARM Linux wrote:
>         d = debugfs_create_dir("pm_debug", NULL);
>         if (IS_ERR_OR_NULL(d))
>                 return PTR_ERR(d);
> 
> Well, covered above.  NULL is success here.

This one is actually worse, because in case of debugfs_create_dir,
a negative error code is documented to mean "success": The debugfs
functions intentionally return ERR_PTR(-ENODEV) when debugfs is
disabled so that any code checking for NULL pretends it is a valid
pointer, but that code is only allowed to pass this pointer into
other debugfs functions that are also stubbed out and never
dereference it.

	Arnd
