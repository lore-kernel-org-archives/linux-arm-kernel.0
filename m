From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 28 Sep 2011 19:11:17 +0200
Subject: MAC firmware does not load due to (commit 288d5abe usermodehelper)
In-Reply-To: <CA+55aFy4aZPdUNBR0O3SP1iRRJyeF9kPZxH9G_eYdxueYskF4g@mail.gmail.com>
References: <20110928120630.GB9456@netboy.at.omicron.at>
	<CA+55aFy4aZPdUNBR0O3SP1iRRJyeF9kPZxH9G_eYdxueYskF4g@mail.gmail.com>
Message-ID: <20110928171115.GA5909@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 08:21:05AM -0700, Linus Torvalds wrote:
> 
> Something seems to be calling ioctl() befor rest_init() has even
> completed. Which sounds odd, but I wonder if the schedule() there
> before it might have let 'init' get going.

It does look like it. The init is busybox, and the startup script does
mount, syslogd, and then ifup, so that all can go by quickly.

> Does something like the attached (UNTESTED) fix it?

Yup, problem cured.

Thanks,
Richard
