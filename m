From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Jan 2015 21:08:14 -0500
Subject: [PATCH v2] irqchip: mediatek: Use IS_ERR() instead of NULL
 pointer check
In-Reply-To: <1418205302-22531-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1418050989-21411-1-git-send-email-yingjoe.chen@mediatek.com>
 <1418205302-22531-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20150107020814.GA24989@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yingjoe,

On Wed, Dec 10, 2014 at 05:55:02PM +0800, Yingjoe Chen wrote:
> Beniamino reported a kernel oops caused by an invalid DT file for the
> mediatek interrupt polarity extension.
> 
> The reason is that the interrupt polarity support for mediatek chips
> merely checks for NULL pointer instead of a casted error return
> value in mtk_sysirq_of_init() so any other casted error value passes
> the NULL pointer check and causes a kernel panic when dereferenced.
> 
> Use IS_ERR() and return the error value via PTR_ERR().
> 
> Reported-and-tested-by: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I applied V2 to irqchip/urgent, and hand-added the changes from V3
because the email formatting was wrong.  I also tweaked the subject
line.

thx,

Jason.
