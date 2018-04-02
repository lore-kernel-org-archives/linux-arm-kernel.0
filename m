From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Apr 2018 16:42:21 +0530
Subject: [PATCH v8 42/42] ARM: dts: da850: Add clocks
In-Reply-To: <cf0c4153-b65d-da57-cd0f-0a16cb186377@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-43-git-send-email-david@lechnology.com>
 <cf0c4153-b65d-da57-cd0f-0a16cb186377@lechnology.com>
Message-ID: <510309d2-2df0-a915-a6f6-082b41c6b28b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2018 10:50 PM, David Lechner wrote:
> On 03/15/2018 09:52 PM, David Lechner wrote:
>> This adds clock provider nodes for da850 and wires them up to all of the
>> devices.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
> 
> ...
> 
> This is the mcasp0: mcasp at 100000 node...
> 
>> @@ -560,6 +720,7 @@
>> ????????????? dmas = <&edma0 1 1>,
>> ????????????????? <&edma0 0 1>;
>> ????????????? dma-names = "tx", "rx";
>> +??????????? clocks = <&psc1 7>;
> 
> After some testing, it looks like it needs to be:
> 
> +??????????? power-domains = <&psc1 7>;
> 
> instead of
> 
> +??????????? clocks = <&psc1 7>;

We should probably have both clocks and power-domains properties for all
PSC clocks. This way, the driver can change without a corresponding DT
update dependency.

Thanks,
Sekhar
