From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 6 May 2015 10:41:07 +0530
Subject: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <1430817426-5241-2-git-send-email-stripathi@apm.com>
 <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
Message-ID: <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 1:11 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, May 5, 2015 at 4:17 AM, Suman Tripathi <stripathi@apm.com> wrote:
>> This patch adds the arasan sdhc nodes to reuse the of-arasan
>> driver for APM X-Gene SoC.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>
> [...]
>
>> @@ -533,6 +567,16 @@
>>                         interrupts = <0x0 0x4f 0x4>;
>>                 };
>>
>> +               sdhc0: sdhc at 1c000000 {
>> +                       device_type = "sdhc";
>
> device_type generally should not be used (there are a few exceptions).

Okay !!

>
>> +                       compatible = "arasan,sdhci-4.9a";
>
> If you ever have an integration or xgene specific problem, you need a
> chip specific compatible.

No it;s a IP level problem. If it's a SoC level then probably we
cann't reuse the existing  arasan version. If anything happens
in future we might need our own version.

>
> Rob



-- 
Thanks,
with regards,
Suman Tripathi
