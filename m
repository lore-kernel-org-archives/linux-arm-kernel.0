From: stigge@antcom.de (Roland Stigge)
Date: Wed, 18 Apr 2012 10:33:52 +0200
Subject: [PATCH v2 3/8] ARM: LPC32xx: clock.c update
In-Reply-To: <20120417210905.GJ6498@mwanda>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-4-git-send-email-stigge@antcom.de>
 <20120417210905.GJ6498@mwanda>
Message-ID: <4F8E7C70.6090900@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2012 11:09 PM, Dan Carpenter wrote:
> On Tue, Apr 17, 2012 at 07:08:22PM +0200, Roland Stigge wrote:
>> Besides switching to the default macro CLKDEV_INIT() for clock registration,
>> this patch actually updates the clock registrations of pl08xdmac.
>>
> 
> When there is a cleanup and a new feature added in the same patch,
> it makes it hard to read...  :/  So when we update pl08xdmac:
> 
> -       CLKDEV_INIT(NULL, "clk_dmac", &clk_dma),
> +       CLKDEV_INIT("pl08xdmac", NULL, &clk_dma),
> 
> What does that actually do?  Is it a bug fix?

The primecell DMA driver refers to this clock via "pl08xdmac", so it
only works with the above line change. Will separate out to another patch.

Thanks,

Roland
