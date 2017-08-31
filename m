From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 31 Aug 2017 08:43:03 +0530
Subject: [net-next PATCHv6 1/2] dt-bindings: net: Add DT bindings for
 Socionext Netsec
In-Reply-To: <20170830151942.GB22289@lunn.ch>
References: <1504088657-6102-1-git-send-email-jaswinder.singh@linaro.org>
 <1504088752-6204-1-git-send-email-jaswinder.singh@linaro.org>
 <20170830151942.GB22289@lunn.ch>
Message-ID: <CABb+yY1+oOvWS5aBHvQQmjPOQEEKfWFguCW1-SQeG339fKfBpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 8:49 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Aug 30, 2017 at 03:55:52PM +0530, Jassi Brar wrote:
>> This patch adds documentation for Device-Tree bindings for the
>> Socionext NetSec Controller driver.
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> ---
>>  .../devicetree/bindings/net/socionext-netsec.txt   | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/socionext-netsec.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/socionext-netsec.txt b/Documentation/devicetree/bindings/net/socionext-netsec.txt
>> new file mode 100644
>> index 0000000..12d596c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/socionext-netsec.txt
>> @@ -0,0 +1,46 @@
>> +* Socionext NetSec Ethernet Controller IP
>> +
>> +Required properties:
>> +- compatible: Should be "socionext,netsecv5"
>> +- reg: Address and length of the register sets, the first is the main
>> +     registers, then the rdlar and tdlar regions for the SoC
>> +- interrupts: Should contain ethernet controller interrupt
>> +- clocks: phandle to any clocks to be switched by runtime_pm
>> +- phy-mode: See ethernet.txt file in the same directory
>
>> +- max-speed: See ethernet.txt file in the same directory
>> +- max-frame-size: See ethernet.txt file in the same directory, if 9000 or
>> +     above jumbo frames are enabled
>> +- local-mac-address: See ethernet.txt file in the same directory
>
> These three are required, not optimal?
>
optional :)

>> +- phy-handle: phandle to select child phy
>> +
>> +Optional properties:
>> +- use-jumbo: Boolean property to suggest if jumbo packets should be used or not
>> +
>> +For the child phy
>> +
>> +- compatible "ethernet-phy-ieee802.3-c22" is needed
>
> This is normally considered optional. Why require it?
>
Yes, will do.

Thanks.
