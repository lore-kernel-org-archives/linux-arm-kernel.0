From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Tue, 5 Jul 2016 14:43:17 +0200
Subject: [linux-sunxi] [PATCH 2/4] power: add axp20x-battery driver
In-Reply-To: <112861467708458@web7h.yandex.ru>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
 <20160701092926.32005-2-icenowy@aosc.xyz>
 <577B44FD.6040404@mailbox.org> <112861467708458@web7h.yandex.ru>
Message-ID: <20160705144317.4a654376@pluto.restena.lu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Jul 2016 16:47:38 +0800 Icenowy Zheng wrote:
> I read the datasheet of axp20x, and then found that this driver does
> not support backup RTC battery.
> (But maybe backup battery do not need a driver -- at least on IBM PC
> it has no driver)

A driver is needed to enable/disable the RTC battery charging (unless
uboot does it).
However all the driver can do according to datasheet is configure the
charge voltage/current or disable charging completely.
Monitoring RTC battery is not possible, neither is presence detection.

So driver should just apply configuration it finds in device-tree and
eventually share that information via power supply class.

> And I don't know whether the axp20x has default Li-ion/LiPo battery
> OCV parameter. (axp22x seems to be have a set of default OCV)

It seems to have default OCV parameters as well. With empty RTC
battery OCV values are present.

> You can test this driver on AXP20x. (I think I didn't access to
> AXP22x-specified registers in the power supply code)

Bruno
