From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 30 Jan 2017 10:51:52 -0600
Subject: [PATCH 1/2] dt-bindings: Document the VC4 DSI module nodes.
In-Reply-To: <87ziibaota.fsf@eliezer.anholt.net>
References: <20170124003853.16418-1-eric@anholt.net>
 <20170124003853.16418-2-eric@anholt.net>
 <CAL_JsqJ=VQSUO5MeHJSCB=_SnmOnA7G1=GhmWYKhjm-47kYV-w@mail.gmail.com>
 <87ziibaota.fsf@eliezer.anholt.net>
Message-ID: <CAL_JsqJSXEjVPHx-2R69qmg1vrjT66MiYwnpD4Ki6gfqNYcTrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 8:41 PM, Eric Anholt <eric@anholt.net> wrote:
> Rob Herring <robh+dt@kernel.org> writes:
>
>> Need to cc DT list if you want it in my queue.
>>
>> On Mon, Jan 23, 2017 at 6:38 PM, Eric Anholt <eric@anholt.net> wrote:
>>> These are part of the vc4 display pipeline.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> ---
>>>  .../devicetree/bindings/display/brcm,bcm-vc4.txt   | 35 ++++++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
>>> index e2768703ac2b..34c7fddcea39 100644
>>> --- a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
>>> +++ b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
>>> @@ -56,6 +56,18 @@ Required properties for V3D:
>>>  - interrupts:  The interrupt number
>>>                   See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>>
>>> +Required properties for DSI:
>>> +- compatible:  Should be "brcm,bcm2835-dsi0" or "brcm,bcm2835-dsi1"
>>
>> Are the blocks different?
>
> They are from the same lineage, but very different (old dsi0 is 1 lane,
> dsi1 is 4 lanes).  You can see how much the registers move around and
> change in the dsi->port conditional blocks in the driver code.

Okay, can you add a note here with this detail. With that,

Acked-by: Rob Herring <robh@kernel.org>
