From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 2 Nov 2015 14:35:06 +0800
Subject: [PATCH 0/2] Mediatek I2C driver fixup
In-Reply-To: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
References: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <1446446106.12497.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-10-27 at 16:59 +0800, Liguo Zhang wrote:
> This series contain two patches, first is to optimize Mediatek I2C driver to use WRRD
> if hardware support auto restart. Because auto restart will issue auto restart
> interrupt, change to use WRRD can reduce interrupt latency. The second is to fix
> multi transfer error in high speed mode. If hardware support auto restart, need driver
> to send master code first.

Please fix checkpatch warning in 2/2, then you get my reviewed-by for
this series:

Reviewed-by:Eddie Huang <eddie.huang@mediatek.com>

> 
> Liguo Zhang (2):
>   i2c: mediatek: add i2c first write then read optimization
>   i2c: mediatek: fix i2c multi transfer issue in high speed mode
> 
>  drivers/i2c/busses/i2c-mt65xx.c | 77 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 71 insertions(+), 6 deletions(-)
