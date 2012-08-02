From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 2 Aug 2012 01:52:49 -0600 (MDT)
Subject: [PATCH 2/3] ARM: OMAP: hwmod: revise deassert sequence
In-Reply-To: <1342466485-1050-3-git-send-email-omar.luna@linaro.org>
References: <1342466485-1050-1-git-send-email-omar.luna@linaro.org>
 <1342466485-1050-3-git-send-email-omar.luna@linaro.org>
Message-ID: <alpine.DEB.2.00.1208020150240.4177@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello OMar,

On Mon, 16 Jul 2012, Omar Ramirez Luna wrote:

> For a reset sequence to complete cleanly, a module needs its
> associated clocks to be enabled, otherwise the timeout check
> in prcm code can print a false failure (failed to hardreset)
> that occurs because the clocks aren't powered ON and the status
> bit checked can't transition without them.
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

Is enabling the clocks sufficient?  Or do we also need to enable the 
IP block, e.g. by calling

	if (soc_ops.enable_module)
		soc_ops.enable_module(oh);

as we do on OMAP4+ in _enable() ?


- Paul
