From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 Sep 2013 21:57:30 -0500
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <5240B07C.6080404@wwwdotorg.org>
References: <20130919105437.75e0f0a3@armhf>
	<5240B07C.6080404@wwwdotorg.org>
Message-ID: <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 4:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:
>> This patch adds a simple sound codec which is described by the DT.
>> This codec may be used when no specific codec action is needed.
>
>> diff --git a/Documentation/devicetree/bindings/sound/simple-codec.txt b/Documentation/devicetree/bindings/sound/simple-codec.txt
>
>> +Device-Tree bindings for the simple codec
>> +
>> +Required properties:
>> +- compatible: should be "linux,simple-codec".
>
> We shouldn't have any Linux-specific bindings. It might be reasonable to
> define a binding for a "simple CODEC", but there's no reason it should
> be Linux-specific.

Further, just define the type of codec h/w. If linux can use its
simple-codec driver for it, then add a match table entry for said
codec. Then the DT is future proof when you decide the simple driver
doesn't really work for that h/w.

Rob
