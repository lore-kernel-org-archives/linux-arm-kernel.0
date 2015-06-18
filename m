From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 18 Jun 2015 17:32:06 +0200
Subject: [PATCH 00/13] Discover and probe dependencies
In-Reply-To: <20150618144934.GM7557@n2100.arm.linux.org.uk>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <55829269.2090309@samsung.com> <20150618103615.GC14071@sirena.org.uk>
 <5582C437.4030108@samsung.com> <20150618144934.GM7557@n2100.arm.linux.org.uk>
Message-ID: <5582E476.6040905@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.06.2015 um 16:49 schrieb Russell King - ARM Linux:

> I think you may need to pick a better example to illustrate your point. :)

It's easy to describe: Sort driver probe calls and forget about the 
whole device-stuff.

The real target is to sort the driver probe calls and ideally the whole 
device stuff could be ignored, leaving it as however it may work.

Unfortunately, that's not as easy to implement as it sounds. ;)

I've too hit the device-stuff very late in my driver-probe-ordering 
experiment and just did it somehow, because I already was at the limit 
of the time I wanted to spend. ;)

So to repeat myself, I think the first target has to be to identify 
drivers either without having to call their initcalls at all, or by 
making sure their initcalls just register and do nothing else (what I've 
called "well-done").

Regards,

Alexander Holler
