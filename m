From: tj@kernel.org (Tejun Heo)
Date: Thu, 11 Feb 2016 10:10:30 -0500
Subject: [PATCH] libata: fix HDIO_GET_32BIT ioctl
In-Reply-To: <1455196595-3466120-1-git-send-email-arnd@arndb.de>
References: <1455196595-3466120-1-git-send-email-arnd@arndb.de>
Message-ID: <20160211151030.GW3741@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 02:16:27PM +0100, Arnd Bergmann wrote:
> As reported by Soohoon Lee, the HDIO_GET_32BIT ioctl does not
> work correctly in compat mode with libata.
> 
> I have investigated the issue further and found multiple problems
> that all appeared with the same commit that originally introduced
> HDIO_GET_32BIT handling in libata back in linux-2.6.8 and presumably
> also linux-2.4, as the code uses "copy_to_user(arg, &val, 1)" to copy
> a 'long' variable containing either 0 or 1 to user space.

Applied to libata/for-4.5-fixes.

Thanks a lot!

-- 
tejun
