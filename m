From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 29 Nov 2017 15:12:58 +0100
Subject: [PATCH] ARM: imx: don't abort MMDC probe if power saving status
 doesn't match
In-Reply-To: <20171129140610.GM9376@dragon>
References: <20171127121139.15584-1-l.stach@pengutronix.de>
 <20171129140610.GM9376@dragon>
Message-ID: <1511964778.17442.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 29.11.2017, 22:06 +0800 schrieb Shawn Guo:
> On Mon, Nov 27, 2017 at 01:11:39PM +0100, Lucas Stach wrote:
> > The power saving status bit will not signal if the MMDC is under
> > load,
> > which is likely during kernel boot.
> 
> What is exactly the condition of MMDC is under load???If it's likely
> hit during kernel boot, why have we not heard any report regarding to
> it before?

There were reports of this before:
https://patchwork.kernel.org/patch/9289077/

Maybe nobody really cared about the issue before, as nothing bad
happened on this check failing. But with the MMDC perf support getting
skipped now, this is rather unfortunate.

I do hit this condition pretty reliably with a recent kernel. Also I
would say it's expected that the MMDC is loaded with memory
transactions during system boot.

Regards,
Lucas
