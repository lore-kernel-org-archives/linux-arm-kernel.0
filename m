From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 13 Jun 2016 09:15:09 +0000
Subject: [PATCH 1/1] ARM: dts: imx6qdl.dtsi: add "arm, shared-override"
 for pl310
In-Reply-To: <20160611115733.GM20243@tiger>
References: <1465292365-26038-1-git-send-email-peter.chen@nxp.com>
 <20160611115733.GM20243@tiger>
Message-ID: <VI1PR04MB1455E287DCD3AD6F555F7B038B530@VI1PR04MB1455.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>Subject: Re: [PATCH 1/1] ARM: dts: imx6qdl.dtsi: add "arm, shared-override" for
>pl310
>
>+ Lucas
>
>On Tue, Jun 07, 2016 at 05:39:25PM +0800, Peter Chen wrote:
>> The imx6 SMP system has the same DMA memory coherency issue [1] with
>> pl310 L2 controller. With this shared override bit set, the customer
>> reports the DMA coherency issue is gone. Besides, I have tested the
>> performance using USB ethernet with/without this bit, it shows no
>> difference.
>>
>> [1] http://patchwork.ozlabs.org/patch/469362/
>>
>> Signed-off-by: Peter Chen <peter.chen@nxp.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi
>> b/arch/arm/boot/dts/imx6qdl.dtsi index ed613eb..30e21ee 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -185,6 +185,7 @@
>>  			cache-level = <2>;
>>  			arm,tag-latency = <4 2 3>;
>>  			arm,data-latency = <4 2 3>;
>> +			arm,shared-override;
>
>Lucas had an objection to the change [1], considering the case that kernel is booted
>as non-secure.
>
>Shawn
>
>[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/471026
>

Add another Lucas in case he changed his email.

Shawn, do you know what his mean? Why other pl310 parameters can be changed in kernel?

Peter
