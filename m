From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 09 Aug 2013 12:05:58 +0200
Subject: [alsa-devel] [PATCH v4 1/1] ASoc: kirkwood: add DT support to
 the mvebu audio subsystem
In-Reply-To: <5204B7A6.9050907@gmail.com>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
Message-ID: <5204BF06.3060806@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2013 11:34 AM, Sebastian Hesselbarth wrote:
> On 08/09/13 11:19, Mark Brown wrote:
>> On Fri, Aug 09, 2013 at 10:23:50AM +0200, Sebastian Hesselbarth wrote:
>>> On 08/08/2013 01:22 PM, Jean-Francois Moine wrote:
>>
>>>> +i2s1: audio-controller at b4000 {
>>>> +    compatible = "mrvl,mvebu-audio";
>>>> +    reg = <0xb4000 0x2210>;
>>>> +    interrupts = <21>, <22>;
>>>> +    clocks = <&gate_clk 13>;
>>>> +    clock-names = "internal";
>>>> +};
>>
>>> Also we will need some phandle reference to the audio codec here. As
>>> this property is ongoing work in ASoC core, I suggest we wait for it
>>> and propose a binding afterwards.
>>
>> No, as discussed this should be in the binding for the audio subsystem
>> not in the binding for an individual component in that subsystem.
>>
> 
> Mark,
> 
> I do understand there may be SoCs requiring sophisticated extra audio
> nodes, but Marvell SoCs don't. I prefer having a single node for the
> i2s controller *and* exploit the audio subsystem properties from that.

It's not about SoCs, it's about the board. The audio fabric on a board can
easily get complex enough to require its own driver. Speakers, mics, jacks
and jack detection, external amplifiers, bluetooth, baseband, multiple
CODECs. That's what the audio node describes.

- Lars
