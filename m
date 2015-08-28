From: fainelli@broadcom.com (Florian Fainelli)
Date: Fri, 28 Aug 2015 09:36:42 -0700
Subject: [PATCH v2 2/5] ARM: NSP: add minimal Northstar Plus device tree
In-Reply-To: <CAL_JsqJb+Pj7c=3Q9ViPhU_=tJxqOzEhOPALctf-zaFHQv+bWg@mail.gmail.com>
References: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
 <1440628530-6137-3-git-send-email-jonmason@broadcom.com>
 <CAL_JsqJb+Pj7c=3Q9ViPhU_=tJxqOzEhOPALctf-zaFHQv+bWg@mail.gmail.com>
Message-ID: <55E08E1A.8050805@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/15 08:41, Rob Herring wrote:
> On Wed, Aug 26, 2015 at 5:35 PM, Jon Mason <jonmason@broadcom.com> wrote:
>> Add a very minimalistic set of Northstar Plus Device Tree files which
>> describes the SoC and the BCM958625 implementation.  The perpherials
>> described are:
>>
>> ARM Cortex A9 CPU
>> 2 8250 UARTs
>> ARM GIC
>> PL310 L2 Cache
>> ARM A9 Global timer
>>
>> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
>> Signed-off-by: Jon Mason <jonmason@broadcom.com>
>> ---
[snip]
>> +       clocks {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges;
>> +
>> +               periph_clk: periph_clk {
>> +                       compatible = "fixed-clock";
>> +                       #clock-cells = <0>;
>> +                       clock-frequency = <500000000>;
>> +               };
>> +       };
>> +
>> +       uart0: serial at 18000300 {
> 
> All these devices should go under a bus node.

Jon, you can send a replacement patch and I would drop this one. Thanks!
-- 
Florian
