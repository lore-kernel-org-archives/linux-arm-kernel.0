From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 12 Feb 2018 00:43:44 +0100
Subject: [patch v14 4/4] Documentation: jtag: Add ABI documentation
In-Reply-To: <1513268971-13518-5-git-send-email-oleksandrs@mellanox.com>
References: <1513268971-13518-1-git-send-email-oleksandrs@mellanox.com>
 <1513268971-13518-5-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20180211234344.GA3864@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> @@ -0,0 +1,27 @@
> +What:		/dev/jtag[0-9]+
> +Date:		October 2017
> +KernelVersion:	4.15
> +Contact:	oleksandrs at mellanox.com
> +Description:
> +		The misc device files /dev/jtag* are the interface
> +		between JTAG master interface and userspace.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include/uapi]<linux/jtag.h>.
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		The argument flag currently support only one access
> +		mode O_RDWR.
> +
> +		ioctl(2)
> +		Initiate various actions.
> +		See the inline documentation in [include/uapi]<linux/jtag.h>
> +		for descriptions of all ioctls.

I tried reading the jtag.h, and am still not sure how it works. Real docs
would be nice...

In particular, it seems to always specify read or write actiom. Sounds
like a job for read/write syscalls?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
