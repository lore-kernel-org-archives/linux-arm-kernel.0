From: andy@warmcat.com (Andy Green)
Date: Mon, 08 Feb 2010 11:03:14 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1265622676.4020.19.camel@pc1117.cambridge.arm.com>
References: <20100208065519.GE1290@ucw.cz>
	<1265622676.4020.19.camel@pc1117.cambridge.arm.com>
Message-ID: <4B6FE162.6000004@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/10 10:51, Somebody in the thread at some point said:

> We could of course flush the caches every time we get a page fault but
> that's far from optimal, especially since DMA-capable drivers to do not
> pollute the D-cache and don't need this extra flushing. Note that the
> recent ARM processors have PIPT caches but separate for I and D and it's
> the PIO drivers that pollute the D-cache.

Just noting that AFAIK iMX31 USB and MMC drivers both are PIO at the 
moment, for lack of any platform DMA support of its unusual DMA engine.

-Andy
