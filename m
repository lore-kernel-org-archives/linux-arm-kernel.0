From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 19 Aug 2015 17:43:46 +0200
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <20150817164003.GB2906@e104818-lin.cambridge.arm.com>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
 <20150817164003.GB2906@e104818-lin.cambridge.arm.com>
Message-ID: <20150819154346.GX1820@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.08.15 17:40:03, Catalin Marinas wrote:
> On Fri, Aug 14, 2015 at 08:28:02PM +0200, Robert Richter wrote:
> > +struct static_key is_cavium_thunderx = STATIC_KEY_INIT_FALSE;

Will add the static ...

> This could also be "static struct ...". BTW, the use of static_key
> directly is deprecated, so just do:
> 
> static DEFINE_STATIC_KEY_FALSE(is_cavium_thunderx);

... and for simplicity a patch with this after the jump laber bits are
merged upstream.

-Robert
