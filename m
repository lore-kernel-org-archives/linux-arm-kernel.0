From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 21 Aug 2013 12:20:45 +0800
Subject: [PATCH 1/3] ARM: imx6q: refactor some ldb related clocks
In-Reply-To: <CAOMZO5Afjp-zPzUaNE63L7Y2LjZbSrLupAJ_jFnf1Gg1+hx0Nw@mail.gmail.com>
References: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
 <1376987932-5540-2-git-send-email-Ying.Liu@freescale.com>
 <CAOMZO5Afjp-zPzUaNE63L7Y2LjZbSrLupAJ_jFnf1Gg1+hx0Nw@mail.gmail.com>
Message-ID: <5214401D.8010402@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 11:40 PM, Fabio Estevam wrote:
> On Tue, Aug 20, 2013 at 5:38 AM, Liu Ying <Ying.Liu@freescale.com> wrote:
> 
>> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> index 5a90a72..90e923e 100644
>> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> @@ -89,8 +89,6 @@ clocks and IDs.
>>         gpu3d_shader            74
>>         ipu1_podf               75
>>         ipu2_podf               76
>> -       ldb_di0_podf            77
>> -       ldb_di1_podf            78
>>         ipu1_di0_pre            79
>>         ipu1_di1_pre            80
>>         ipu2_di0_pre            81
> 
> This causes a 'hole' in the clock numbering scheme: 74, 75, 76, 79, 80, etc
> 

I find there is a 'hole' in Documentation/devicetree/bindings/clock/imx5-clock.txt as well.
The 'hole' was taken by tve_di(26) clock before.

Is this more acceptable?

ldb_di0_podf_unused            77
ldb_di1_podf_unused            78

Liu Ying
