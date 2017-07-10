From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 10 Jul 2017 12:31:19 +0300
Subject: [PATCH v 1/2] ravb: Add support for r8a7743 SoC
In-Reply-To: <20170710012024.j4cso2jyi6canws2@rob-hp-laptop>
References: <1499259711-56175-1-git-send-email-biju.das@bp.renesas.com>
 <1499259711-56175-2-git-send-email-biju.das@bp.renesas.com>
 <20170710012024.j4cso2jyi6canws2@rob-hp-laptop>
Message-ID: <7a631876-900e-66fb-c389-a33b9a146a8e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 7/10/2017 4:20 AM, Rob Herring wrote:

>> Add support for Gigabit Ethernet E-MAC on r8a7743 (RZ/G1M) SoC.
>> Renesas RZ/G1M (R8A7743) SoC Ethernet AVB IP is identical to the R-Car Gen2
>> family.
> 
> For the subject: "dt-bindings: net: ..."
> 
>>
>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
>> ---
>>   Documentation/devicetree/bindings/net/renesas,ravb.txt | 3 ++-
>>   drivers/net/ethernet/renesas/ravb_main.c               | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
>> index b519503..bc692ab 100644
>> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
>> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
>> @@ -4,7 +4,8 @@ This file provides information on what the device node for the Ethernet AVB
>>   interface contains.
>>   
>>   Required properties:
>> -- compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
>> +- compatible: "renesas,etheravb-r8a7743" if the device is a part of R8A7743 SoC.
>> +	      "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
> 
> Please re-format like this:
> 
> - compatible: Must be one of:
> ...
> 
> So it's a one line change to add new compatibles.

    Note that the common gen2/3 values are at end of this list, so they'll 
need different treating if you add these words.

MBR, Sergei
