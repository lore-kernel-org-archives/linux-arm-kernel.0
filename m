From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Sep 2013 10:49:06 -0600
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
References: <20130919105437.75e0f0a3@armhf> <5240B07C.6080404@wwwdotorg.org>
 <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
Message-ID: <5249AB82.60701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 08:57 PM, Rob Herring wrote:
> On Mon, Sep 23, 2013 at 4:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:
>>> This patch adds a simple sound codec which is described by the DT.
>>> This codec may be used when no specific codec action is needed.
>>
>>> diff --git a/Documentation/devicetree/bindings/sound/simple-codec.txt b/Documentation/devicetree/bindings/sound/simple-codec.txt
>>
>>> +Device-Tree bindings for the simple codec
>>> +
>>> +Required properties:
>>> +- compatible: should be "linux,simple-codec".
>>
>> We shouldn't have any Linux-specific bindings. It might be reasonable to
>> define a binding for a "simple CODEC", but there's no reason it should
>> be Linux-specific.
> 
> Further, just define the type of codec h/w. If linux can use its
> simple-codec driver for it, then add a match table entry for said
> codec. Then the DT is future proof when you decide the simple driver
> doesn't really work for that h/w.

The only potential issue with that approach is if the CODEC can be used
in a "simple" mode where e.g. no control GPIOs, regulator manipulation,
etc. are required, or in a more complex mode where such things are
required, you may end up with the device-specific binding being written
to the simple mode, and hence missing features required for the complex
mode. Having a separate simple binding prevents the device-specific
binding from being broken that way.

That said, it's probably better to simply get the device-specific
binding completely fleshed out and representing all resources the first
time around, then there's no issue either.
