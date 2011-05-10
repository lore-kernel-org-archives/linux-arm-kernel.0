From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 May 2011 23:40:45 +0100
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <BANLkTi=XSevO72NqCYOYuketjE8XjeQU+A@mail.gmail.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
	<1304365077.7792.40.camel@Joe-Laptop>
	<BANLkTi=XSevO72NqCYOYuketjE8XjeQU+A@mail.gmail.com>
Message-ID: <20110510224045.GA19154@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 12:18:00AM +0200, Linus Walleij wrote:

> This is the idiomatic way of providing sysfs strings (compare e.g.
> *_show() in drivers/regulator/core.c), the char *buf comes
> from the sysfs core in struct device_attribute in <linus/device.h>
> with this prototype:

>  ssize_t (*show)(struct device *dev, struct device_attribute *attr,
>                         char *buf);

> and I have no way of knowing how large that buffer is. Migrating all

It's implicitly PAGE_SIZE.  In pretty much all users the buffer is
constrained to well below that by the inputs (sometimes with some help
from users not using insanely long names for things) and the sysfs
semantics which mean you probably got something badly wrong if you get
anywhere near PAGE_SIZE.
