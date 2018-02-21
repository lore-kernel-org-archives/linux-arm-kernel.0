From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Feb 2018 19:23:40 +0100
Subject: [PATCH v2 19/19] ARM64: dts: r8a77965: Add EtherAVB device node
In-Reply-To: <35959135-cb3b-040a-1944-26845e0c07b0@cogentembedded.com>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-20-git-send-email-jacopo+renesas@jmondi.org>
 <cf157266-5ea7-6795-1e31-0d1ccf85e7e8@cogentembedded.com>
 <20180221100716.GF7203@w540>
 <cbeb1b6b-1b02-7665-0f1f-847ab8de69e3@cogentembedded.com>
 <20180221173106.vgyshbz3kkc4p3cu@verge.net.au>
 <321c6c8c-8853-ac00-7567-c0be82b510f4@cogentembedded.com>
 <35959135-cb3b-040a-1944-26845e0c07b0@cogentembedded.com>
Message-ID: <20180221182340.wvdvgtv5pw7pvd3v@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 08:53:53PM +0300, Sergei Shtylyov wrote:
> On 02/21/2018 08:38 PM, Sergei Shtylyov wrote:

...

> >>>>>> +			clocks = <&cpg CPG_MOD 812>;
> >>>>>> +			power-domains = <&sysc 32>;
> >>>>>> +			resets = <&cpg 812>;
> >>>>>> +			phy-mode = "rgmii-txid";
> >>>>>
> >>>>>    Why not just "rgmii"? TX delay is a board specific detail, no?
> >>>>>
> >>>> I admit I took this one straight from r8a7796 dtsi.
> >>>> Would you like to me resend and change this?
> >>>
> >>>    Yes, unless Simon would fix it while merging...
> >>
> >> Can I confirm the desired change is s/rgmii-txid/rgmii/ ?
> > 
> >    Yes.
> 
>    Apparently that means that this prop should be overridden in the board file
> (which may not be an easy task given the board is Salvator-XS again).
> 
> [...]

Can we override it in r8a77965-salvator-x.dts or r8a77965-salvator-xs.dts?

I feel that I'm missing an important point here.
