From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Jul 2011 18:42:08 +0900
Subject: [PATCH 4/7] ARM: EXYNOS4: Support early wakeup while entering
	sleep mode
In-Reply-To: <20110701074414.GD21898@n2100.arm.linux.org.uk>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-5-git-send-email-kgene.kim@samsung.com>
	<20110622145715.GS23234@n2100.arm.linux.org.uk>
	<007401cc3242$48947160$d9bd5420$%kim@samsung.com>
	<20110624093750.GD23234@n2100.arm.linux.org.uk>
	<20110624102246.GF23234@n2100.arm.linux.org.uk>
	<017d01cc378a$c017edf0$4047c9d0$%kim@samsung.com>
	<20110701074414.GD21898@n2100.arm.linux.org.uk>
Message-ID: <005001cc3a2e$a6689480$f339bd80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Fri, Jul 01, 2011 at 10:03:48AM +0900, Kukjin Kim wrote:
> > Russell thanks.
> >
> > How do you think to add following for handling failure of cpu_suspend?
> >
> > +	mov	r0, #-1
> 
> No.  -1 is not an error code, and I refuse to create functions which
> use an explicit -1 as a return code to indicate failure.
> 
I used wrong words, 'handling failure' :(

Actually, it means handling other case, like early wakeup but we will
address comments from you :)

> The code is designed so that the called finisher function can return
> a valid errno value.

OK, I see.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
