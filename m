From: carlo@caione.org (Carlo Caione)
Date: Mon, 3 Mar 2014 14:37:30 +0100
Subject: [linux-sunxi] Re: [PATCH v4 3/3] ARM: sun7i/sun6i: irqchip:
 Update the documentation
In-Reply-To: <20140303110240.GW607@lukather>
References: <1393529662-8663-1-git-send-email-carlo@caione.org>
 <1393529662-8663-4-git-send-email-carlo@caione.org>
 <20140303110240.GW607@lukather>
Message-ID: <CAOQ7t2Z6UuKNfUDUYC1oaZAHKQ-3Sjffe-M2h1GACsERbV9_jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 12:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Feb 27, 2014 at 08:34:22PM +0100, Carlo Caione wrote:
>> Added documentation for NMI irqchip.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  .../allwinner,sun67i-sc-nmi.txt                    | 27 ++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
>> new file mode 100644
>> index 0000000..ac31487
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
>> @@ -0,0 +1,27 @@
>> +Allwinner Sunxi NMI Controller
>> +==============================
>> +
>> +Required properties:
>> +
>> +- compatible : should be "allwinner,sun7i-a20-sc-nmi" or
>> +  "allwinner,sun6i-a31-sc-nmi"
>> +- reg : Specifies base physical address and size of the registers.
>> +- interrupt-controller : Identifies the node as an interrupt controller
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source. The value shall be 2. The first cell is the IRQ number, the
>> +  second cell the trigger type.
>
> What values correspond to what trigger type? What are the accepted values?
>
>> +- interrupt-parent: Specifies the parent interrupt controller.
>> +- interrupts: Specifies the list of interrupt lines which are handled by
>> +  the interrupt controller in the parent controller's notation. This value
>> +  shall be the NMI.
>
> Hmmm, there's only one interrupt, not a list of them.

Fix for both in v5.

Thank you,

-- 
Carlo Caione
