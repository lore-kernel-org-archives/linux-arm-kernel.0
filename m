From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Jan 2017 16:20:10 -0600
Subject: [PATCH v1 2/2] arm: dts: mt2701: add nor flash node
In-Reply-To: <20170117143650.5db87148@free-electrons.com>
References: <d7b866ad-5b2f-62d3-3aa3-6fa42803d625@gmail.com>
 <b850b751-1d8d-0053-cf1f-d5314542e5c3@gmail.com>
 <20170113172825.75d545a3@bbrezillon>
 <86c997be-f500-eaa1-3ba5-d21cff6223b7@gmail.com>
 <20170113175628.1793f433@bbrezillon>
 <0fafcd8d-cf99-de6b-728f-5e3637810b68@gmail.com>
 <20170114092958.022f2fc8@bbrezillon>
 <e7fa1542-f0e2-0e45-23b3-25d6491ae40d@gmail.com>
 <20170116094032.6f471f11@bbrezillon>
 <20170117143650.5db87148@free-electrons.com>
Message-ID: <20170118222010.ivc6jxpnrumemvdf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 02:36:50PM +1100, Thomas Petazzoni wrote:
> Hello,
> 
> (Side note: you guys should learn about stripping irrelevant parts of
> an e-mail when replying!)
>
> On Mon, 16 Jan 2017 09:40:32 +0100, Boris Brezillon wrote:
> 
> > > Well this is OK I guess, but then you can also use "mediatek,mt8173-nor"
> > > as the oldest supported compatible and be done with it, no ? It looks a
> > > bit crappy though, I admit that ...
> > 
> > Let's stop bikeshedding and wait for DT maintainers feedback
> > before taking a decision ;-).
> > 
> > Rob, Mark, any opinion?
>

Sigh, is how to do compatibles really not yet understood?
 
> I agree that a clarification would be good. There are really two
> options:
> 
>  1. Have two compatible strings in the DT, the one that matches the
>     exact SoC where the IP is found (first compatible string) and the
>     one that matches some other SoC where the same IP is found (second
>     compatible string). Originally, Linux only supports the second
>     compatible string in its device driver, but if it happens that a
>     difference is found between two IPs that we thought were the same,
>     we can add support for the first compatible string in the driver,
>     with a slightly different behavior.

This. And no wildcards in the compatible string. 

>  2. Have a single compatible string in the DT, matching the exact SoC
>     where the IP is found. This involves adding immediately this
>     compatible string in the corresponding driver.

I wouldn't object to this from a DT perspective as I have no clue 
generally if IP blocks are "the same" or not. Subsystem maintainers will 
object though.

> I've not really been able to figure out which of the two options is the
> most future-proof/appropriate.

They are both future-proof. #2 has the disadvantage of requiring a 
kernel update for a new SoC. 

Rob
