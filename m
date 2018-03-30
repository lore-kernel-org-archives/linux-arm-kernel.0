From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Mar 2018 17:13:31 +0800
Subject: [PATCH net-next 03/12] dt-bindings: net: dwmac-sun8i: Clean up
 clock delay chain descriptions
In-Reply-To: <eb47a027-c678-7496-ef58-fc8e96be7dd9@cogentembedded.com>
References: <20180317092857.4396-1-wens@csie.org>
 <20180317092857.4396-4-wens@csie.org>
 <eb47a027-c678-7496-ef58-fc8e96be7dd9@cogentembedded.com>
Message-ID: <CAGb2v679OxYOFxz6pHa9W11EVa9ZYD6N3HfdjaTPpKkVe5qngg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2018 at 5:21 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello!
>
>
> On 3/17/2018 12:28 PM, Chen-Yu Tsai wrote:
>
>> The clock delay chains found in the glue layer for dwmac-sun8i are only
>> used with RGMII PHYs. They are not intended for non-RGMII PHYs, such as
>> MII external PHYs or the internal PHY. Also, a recent SoC has a smaller
>> range of possible values for the delay chain.
>>
>> This patch reformats the delay chain section of the device tree binding
>> to make it clear that the delay chains only apply to RGMII PHYs, and
>> make it easier to add the R40-specific bits later.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>   Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>> b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>> index 3d6d5fa0c4d5..b8a3028d6c30 100644
>> --- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>> +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>> @@ -28,10 +28,13 @@ Required properties:
>>     - allwinner,sun8i-a83t-system-controller
>>     Optional properties:
>> -- allwinner,tx-delay-ps: TX clock delay chain value in ps. Range value is
>> 0-700. Default is 0)
>> -- allwinner,rx-delay-ps: RX clock delay chain value in ps. Range value is
>> 0-3100. Default is 0)
>> -Both delay properties need to be a multiple of 100. They control the
>> delay for
>> -external PHY.
>> +- allwinner,tx-delay-ps: TX clock delay chain value in ps.
>> +                        Range is 0-700. Default is 0.
>> +- allwinner,rx-delay-ps: RX clock delay chain value in ps.
>> +                        Range is 0-3100. Default is 0.
>> +Both delay properties need to be a multiple of 100. They control the
>> +clock delay for external RGMII PHY. They are do apply to the internal
>
>
>   s/are do/do not/?

Fixed. Thanks!

ChenYu
