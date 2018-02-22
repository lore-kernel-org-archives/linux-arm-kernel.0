From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 22 Feb 2018 22:08:46 +0300
Subject: [PATCH v2 19/19] ARM64: dts: r8a77965: Add EtherAVB device node
In-Reply-To: <20180222155411.gnn42poawtlf3rze@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-20-git-send-email-jacopo+renesas@jmondi.org>
 <cf157266-5ea7-6795-1e31-0d1ccf85e7e8@cogentembedded.com>
 <20180221100716.GF7203@w540>
 <cbeb1b6b-1b02-7665-0f1f-847ab8de69e3@cogentembedded.com>
 <20180221173106.vgyshbz3kkc4p3cu@verge.net.au>
 <321c6c8c-8853-ac00-7567-c0be82b510f4@cogentembedded.com>
 <35959135-cb3b-040a-1944-26845e0c07b0@cogentembedded.com>
 <20180221182340.wvdvgtv5pw7pvd3v@verge.net.au>
 <eaf3c72b-a482-86cf-88e7-4af457f74558@cogentembedded.com>
 <20180222155411.gnn42poawtlf3rze@verge.net.au>
Message-ID: <fceb1fd4-b0bd-7061-7cb8-c33f2a05c503@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 02/22/2018 06:54 PM, Simon Horman wrote:

>>> ...
>>>
>>>>>>>>>> +			clocks = <&cpg CPG_MOD 812>;
>>>>>>>>>> +			power-domains = <&sysc 32>;
>>>>>>>>>> +			resets = <&cpg 812>;
>>>>>>>>>> +			phy-mode = "rgmii-txid";
>>>>>>>>>
>>>>>>>>>    Why not just "rgmii"? TX delay is a board specific detail, no?
>>>>>>>>>
>>>>>>>> I admit I took this one straight from r8a7796 dtsi.
>>>>>>>> Would you like to me resend and change this?
>>>>>>>
>>>>>>>    Yes, unless Simon would fix it while merging...
>>>>>>
>>>>>> Can I confirm the desired change is s/rgmii-txid/rgmii/ ?
>>>>>
>>>>>    Yes.
>>>>
>>>>    Apparently that means that this prop should be overridden in the board file
>>>> (which may not be an easy task given the board is Salvator-XS again).
>>>>
>>>> [...]
>>>
>>> Can we override it in r8a77965-salvator-x.dts or r8a77965-salvator-xs.dts?
>>
>>    In salvator-common.dtsi most probably -- it has the PHY data for Ether AVB.
>>
>>> I feel that I'm missing an important point here.
>>
>>    Well, r8a779{5|6}.dtsi also have phy-mode = "rgmii-txid" (which was
>>    unjustified in my current understanding). Thus such board override
>>    wouldn't hurt them. But we lack a patch modifying salvator-common.dtsi
>>    in htis series, so I'm now thinking a respin of this series is needed
>>    anyway... sorry for being unclear. :-)
> 
> While I've applied other patches in this series I have
> not applied this one - mainly to allow this discussion to conclude.
> 
> Is an appropriate solution to do the following?
> 
> 1) Atomically update
>    a) r8a779{5|6}.dtsi to use "rgmii" and
>    b) salvator-common.dtsi to use "rgmii-txid"
> 2) Update this patch to use "rgmii"

   Yeah, I was thinking about doing exactly this...

> Sorry if I'm still missing the point.

   I was referring to what the 2nd paragraph of [1] said about the internal delays
(perhaps I just misunderstood it)...

[1] https://en.wikipedia.org/wiki/Media-independent_interface#Reduced_gigabit_media-independent_interface

MBR, Sergei
