From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 07 Aug 2015 10:11:23 +0100
Subject: [PATCH 2/3] nvmem: imx-ocotp: Add i.MX6 OCOTP driver
In-Reply-To: <1438933597.3638.5.camel@pengutronix.de>
References: <1438693342-605-1-git-send-email-p.zabel@pengutronix.de>		
 <1438693342-605-2-git-send-email-p.zabel@pengutronix.de>		
 <55C38941.9090709@linaro.org> <1438878490.3223.10.camel@pengutronix.de>	
 <55C3B74F.5010501@linaro.org> <1438933597.3638.5.camel@pengutronix.de>
Message-ID: <55C4763B.4090508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/08/15 08:46, Philipp Zabel wrote:
>>> Nobody. I had initially copied the code that actually senses the fuses,
>>> > >but since this happens during power-on reset anyway (all values are
>>> > >stored in shadow registers), I didn't see the point and dropped it for
>>> > >now.
>>> > >The shadow registers are clocked directly by the ungated ipg_root clock.
>> >
>> >So, are you planning to drop the clocks property from the bindings too?
> The gated clock input exists and is needed for the full functionality of
> the device (writing and re-sensing fuses).
Thanks for clarification.

--srini
  It should be in the device
> tree even if the linux driver doesn't implement writing.
>
> regards
> Philipp
>
