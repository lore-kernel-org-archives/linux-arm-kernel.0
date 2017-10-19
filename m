From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Oct 2017 16:58:21 -0500
Subject: [PATCH v2 1/5] dt-bindings: iio: at91-sama5d2_adc: add optional
 dma property
In-Reply-To: <20171019111417.7rzdnkvtukzzhl2u@piout.net>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
 <1507703732-29175-2-git-send-email-eugen.hristev@microchip.com>
 <20171013215142.vlfhzzzetmc7resq@rob-hp-laptop>
 <20171019111417.7rzdnkvtukzzhl2u@piout.net>
Message-ID: <CAL_JsqLPMeF9EtcCO3eZn+7DbyAQcxzNYEpAiFvQoe1=ytpELQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 6:14 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 13/10/2017 at 16:51:42 -0500, Rob Herring wrote:
>> On Wed, Oct 11, 2017 at 09:35:28AM +0300, Eugen Hristev wrote:
>> > Added property for DMA configuration of the device.
>> >
>> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>> > ---
>> >  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
>> > index 552e7a8..5f94d479 100644
>> > --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
>> > +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
>> > @@ -17,6 +17,11 @@ Required properties:
>> >    This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
>> >    IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
>> >
>> > +Optional properties:
>> > +  - dmas: Phandle to dma channel for the ADC.
>> > +  See ../../dma/dma.txt for details.
>> > +  - dma-names: Must be "rx" when dmas property is being used.
>>
>> -names is pointless when there is only one.
>>
>
> You didn't reply to the question I had previously about that: What if at
> some point, we have multiple dmas in the same binding?

Then add dma-names at that point and rx has to be first. If you know
there's other channels, then add them now. Don't evolve the bindings
needlessly based on what a driver supports.

Would another channel make sense here? Maybe multi-channel rx in which
case your naming wouldn't be setup for that. But "tx" on an ADC?

Rob
