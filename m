From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 1 Mar 2011 14:11:06 +0000
Subject: [PATCH 1/4] ASoC: Add TI tlv320aic32x4 codec support.
In-Reply-To: <AANLkTinjj8rZS_Y9qiHbrU2nAYSXTikTNtyU71Bk7UqL@mail.gmail.com>
References: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
	<20110228150014.GI13869@opensource.wolfsonmicro.com>
	<AANLkTinjj8rZS_Y9qiHbrU2nAYSXTikTNtyU71Bk7UqL@mail.gmail.com>
Message-ID: <20110301141105.GF9662@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 08:59:23AM +0100, javier Martin wrote:

> > What are these "aic32x4_configs" all about? ?They look like you're
> > setting non-default configurations...

> This tlv320aic32x4 codec is kind of a huge monster; it has more than
> 200 registers which provide more flexibility than it is needed.

So what is all this magic stuff and why is it using such an odd way of
implementing whatever it's doing?  Part of the problem here is that the
functionality is scattered all the way through the driver so it's less
clear than it should be what's going on.

> For example, BCLK and MCLK are forced here to derive from internal PLL
> which is needed for frequency calculation table to be valid. Bypassing
> this PLL doesn't provide new or better functionality.

I rather suspect it provides lower power consumption.

> The same happens regarding DAC internal connections. I don't think
> allowing the user to swap left and right channels makes sense here.

There are a number of CPUs out there that end up being happier with
channels in the wrong order due to peculiarities of the DMA.  This is
also used to get a microphone input connected to the right analogue
input to appear on the left channel of a recording for mono use.
