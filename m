From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Tue, 03 Feb 2015 17:18:45 -0300
Subject: [linux-sunxi] Re: [PATCH v4] dma: sun4i: Add support for the
 DMA engine on sun[457]i SoCs
In-Reply-To: <CAKON4Oydvex28FsYsHOr3Cv9othhUqu=xOEuLPMcisLPtc1imA@mail.gmail.com>
References: <1422745124-22103-1-git-send-email-emilio@elopez.com.ar>	<1422745124-22103-2-git-send-email-emilio@elopez.com.ar>	<1422785038.28275.34.camel@plaes.org>	<54D116D4.3030004@elopez.com.ar>
 <CAKON4Oydvex28FsYsHOr3Cv9othhUqu=xOEuLPMcisLPtc1imA@mail.gmail.com>
Message-ID: <54D12D25.5000408@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 03/02/15 a las 16:39, jonsmirl at gmail.com escibi?:
> Did you fix multiple simultaneous DMA transfers in this? And easy test
> is to start jack audio. Jack will start simultaneous cyclic transfers
> on both the ALSA input and output. Since cyclic transfers never end,
> multiple simultaneous transfers has to work. Last time I tried it I
> got an immediate GPF when the second cyclic transfer was started.

I didn't get a chance to test with jack yet, but I don't see any reason 
why two cyclic transfers wouldn't work, assuming they're on different 
vchans.

Were you by any chance booting off of NAND by the way? That caused a GPF 
because the bootloader left the hardware in a dirty state, but it should 
be fixed now.

Cheers,

Emilio
