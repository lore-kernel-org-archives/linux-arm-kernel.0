From: gregor.boirie@parrot.com (=?UTF-8?B?R3LDqWdvciBCb2lyaWU=?=)
Date: Fri, 1 Jun 2012 12:06:47 +0200
Subject: pinctrl: group/pin identity mapping
Message-ID: <4FC89437.1070304@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I'm trying to implement pinctrl support for our new cortex based SoC.
Our driver should provide support for pinctrl/pinmux/pinconf combination
without device tree handling at the moment.
However, I'm afraid I misunderstand how groups relate to muxed pins and
I'd like to hear your suggestions.

Here's the HW: our I/O pins subsystem allows us to multiplex every
controllable pins using up to 4 mutually exclusive functions, i.e. there
is no notion of pin GROUP multiplexing at the HW level (one register per
pin is available to setup multiplexing and other electronic properties
like drive strength, pull up/down...).

However, it seems the pinctrl subsystem requires the driver to provide
pin groups for pinmux implementation.
So my question is: having no notion of HW pin groups whatsoever, should I:

1) implement a software/logical group that would arbitrarily gather
multiple HW pins in a platform dependent manner ?

2) perform an identity mapping between HW pin and software/logical group
with up to 4 groups/HW pins per pinmux function ?

3) anything else ? any way to bypass the pinctrl group logic to directly
assign pins rather than groups to pinmux functions ?

Hope this is clear enought. Regards,
gr?gor

-- 
Gr?gor Boirie
Software engineer
R&D / OS platform
tel +33 1 48 03 73 24
-----------------------------------------
Parrot
174, quai de Jemmapes
75010 Paris  France
tel + 33 1 48 03 60 60
fax + 33 1 48 03 06 66
-----------------------------------------
http://www.parrot.com
