From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 14 Feb 2011 01:57:39 -0800
Subject: [PATCH 2/2 v2] dma: ipu_idmac: do not lose valid received data in
	the irq handler
In-Reply-To: <Pine.LNX.4.64.1102071740380.31738@axis700.grange>
References: <1296031789-1721-3-git-send-email-agust@denx.de>
	<1296476549-10421-1-git-send-email-agust@denx.de>
	<Pine.LNX.4.64.1102031104090.21719@axis700.grange>
	<20110205143505.0b300a3a@wker>
	<Pine.LNX.4.64.1102051735270.11500@axis700.grange>
	<20110205210457.7218ecdc@wker>
	<Pine.LNX.4.64.1102071205570.29036@axis700.grange>
	<20110207122147.4081f47d@wker>
	<Pine.LNX.4.64.1102071232440.29036@axis700.grange>
	<20110207144530.70d9dab1@wker>
	<Pine.LNX.4.64.1102071740380.31738@axis700.grange>
Message-ID: <AANLkTinpP6hoy_cz7qb1+izjO6_LEeQDfVfVwB-QrRiu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 7, 2011 at 8:49 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Ok, I've found the reason. Buffer number repeats, when there is an
> underrun, which is happening in my tests, when frames are arriving quickly
> enough, but the user-space is not fast enough to process them, e.g., when
> it is writing them to files over NFS or even just displaying on the LCD.
> Without your patch these underruns happen just as well, they just don't
> get recognised, because there's always one buffer delayed, so, the queue
> is never empty.
>
> Dan, please add my
>
> Reviewed-(and-tested-)by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, applied v2.

--
Dan
