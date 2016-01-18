From: leoli@freescale.com (Li Yang)
Date: Mon, 18 Jan 2016 16:09:22 +0800
Subject: [PATCH v2] dts/ls2080a: Update PCIe compatible
In-Reply-To: <BY2PR03MB3169DD34DF302BCF7A60FF284090@BY2PR03MB316.namprd03.prod.outlook.com>
References: <1449224417-20753-1-git-send-email-Mingkai.Hu@freescale.com>
 <20151204162243.GA12415@rob-hp-laptop>
 <BY2PR03MB3169DD34DF302BCF7A60FF284090@BY2PR03MB316.namprd03.prod.outlook.com>
Message-ID: <CADRPPNSpf6--KFqaFD8AV8jyUCZ1eD=F2pipHz1_zaR16ec4_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2015 at 4:44 PM, Hu Vincent <Mingkai.Hu@freescale.com> wrote:
>
>
>> -----Original Message-----
>> From: Rob Herring [mailto:robh at kernel.org]
>> Sent: Saturday, December 05, 2015 12:23 AM
>> To: Hu Mingkai-B21284
>> Cc: arm at kernel.org; devicetree at vger.kernel.org; Li Yang-Leo-R58472;
>> linux-arm-kernel at lists.infradead.org; Lian Minghuan-B31939
>> Subject: Re: [PATCH v2] dts/ls2080a: Update PCIe compatible
>>
>> On Fri, Dec 04, 2015 at 06:20:17PM +0800, Mingkai Hu wrote:
>> > From: Minghuan Lian <Minghuan.Lian@freescale.com>
>> >
>> > The patch adds LS2085a to PCIe compatible to fix the compatibility
>> > issue when using firmware with LS2085a compatible property.
>> >
>> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> > Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
>> > ---
>> > v2 change:
>> >  - Rebased to latest kernel base
>>
>> How about implementing my comments on v1, too?
>>
>
> Hi Rob,
>
> Do you mean to change the combinations in layerscape-pci.txt as follows?
>
>> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>> @@ -15,6 +15,7 @@ Required properties:
>>  - compatible: should contain the platform identifier such as:
>>          "fsl,ls1021a-pcie", "snps,dw-pcie"
>> -        "fsl,ls2080a-pcie", "snps,dw-pcie"
>> +        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
>
>
> And the ls2085a was released first, but the dts file is for ls2080a (fsl-ls2080a.dtsi),
> So I prefer to put the ls2080a as the first compatible string. How about your suggestion?

I think this is what Rob suggested in v1 to make the combination in
document align with real dts. And it would be good to also have an
entry for ls2085: "fsl,ls2085a-pcie", "snps,dw-pcie".  Can you send an
updated version?

Regards,
Leo
