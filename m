From: x0148406@ti.com (Afzal Mohammed)
Date: Fri, 19 Oct 2012 21:04:31 +0530
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <5076B166.2020006@gmail.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com>
Message-ID: <50817307.50509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thursday 11 October 2012 05:15 PM, Daniel Mack wrote:

> Could you tell me which patches I need on top of soon-to-be-3.7-rc1? I
> would like to augment this to make GPMC attached NAND probable in DT, in
> case this is still an open topic.

In case you can help on making gpmc nand dt probable, please
proceed. I would be on vacation next week, may be we can
discuss after I am back.

am335x based boards like beagle bone should be booting on
l-o master and it has gpmc header cleanup changes with
minimal driver support.

As I don't have the sufficient time to explain in detail, some
pointers. Discussion between us [1] hopefully explains it in brief.
It would be like peripherals connected to gpmc being represented
as child nodes in dt. gpmc driver probably in probe would have to
invoke of_platform_populate to create child nodes (for devices like
nand). And driver would have to be enhanced to configure gpmc
based on information passed through dt for each child nodes.
Or roughly have a dt equivalent of driver as in [2].

One issue would be the memory resource creation by gpmc
driver and which has to be provided to client resource data.
And a decision has to be taken whether a generic routine is
going to be used or initially a custom routine invocation
based on child compatible fields would be sufficient.

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg74397.html
[2] git://gitorious.org/x0148406-public/linux-kernel tags/gpmc-drv-v6
