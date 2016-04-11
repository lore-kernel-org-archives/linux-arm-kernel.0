From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 11 Apr 2016 16:00:03 +0200
Subject: [PATCH 1/2] clk: Add Oxford Semiconductor OXNAS Standard Clocks
In-Reply-To: <20160407233113.GI18567@codeaurora.org>
References: <1459520791-13269-1-git-send-email-narmstrong@baylibre.com>
 <1459520791-13269-2-git-send-email-narmstrong@baylibre.com>
 <20160402005045.GX18567@codeaurora.org> <5701210A.4060807@baylibre.com>
 <20160407233113.GI18567@codeaurora.org>
Message-ID: <570BADE3.8080201@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2016 01:31 AM, Stephen Boyd wrote:
> On 04/03, Neil Armstrong wrote:
>> On 04/02/2016 02:50 AM, Stephen Boyd wrote:
> 
> Ok. I was hoping that we could make simple-mfd look to see if
> there's a syscon and then attach it to the parent device, but it
> seems that simple-mfd is not actually a driver and it might not
> even make a parent device for the children nodes?
> 

It seems so, I will look at the device hierarchy next week.
Syscon is only used by these syscon_node_to_regmap() or similar calls, and they are the only APIs available.

This call is at least used by clk-mtk, nxp and at91 clocks, is there a plan for these to change to another API ?

Neil
