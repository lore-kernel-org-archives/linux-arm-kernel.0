From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 25 Nov 2014 15:02:07 +0200
Subject: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb
 extensions
In-Reply-To: <54747B72.1050406@redhat.com>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
 <547476DA.2030004@ti.com> <54747B72.1050406@redhat.com>
Message-ID: <54747DCF.9010502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/14 14:52, Hans de Goede wrote:

>>> +Required properties:
>>> +- compatible: "allwinner,simple-framebuffer"
>>> +- allwinner,pipeline, one of:
>>
>> Sorry my ignorance, but what's sunxi and what's allwinner? Both names
>> are mixed here.
> 
> sunxi is the sun#i SoCs from Allwinner, Allwinner is the manufacturer
> and the
> SoC "code" names used everywhere in the kernel for their SoCs are sun4i,
> sun5i,
> sun6i, etc. Most people refer to these SoCs as sunxi. This is also what the
> linux-sunxi mailinglist in the Cc is about.
> 
> The official devicetree vendor prefix for Allwinner is allwinner, hence the
> allwinner in the compatible name, see e.g. also
> 
> Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> 
> Which also uses sunxi / sun4i everywhere except in the compatible vendor
> prefix.

Alright, thanks for explanation.

Shouldn't the compatible then be "allwinner,sunxi-simple-framebuffer",
to differentiate from some other SoC Allwinner has or might create in
the future? That is, presuming you're confident enough that a single
compatible string covers all the current and forthcoming sunxi SoCs.

Perhaps simplefb is a bit special case, but I usually feel better if the
compatible string is defined in a more specific manner. In this case I'd
have:

allwinner,sun4i-simple-framebuffer
allwinner,sun5i-simple-framebuffer
allwinner,sun6i-simple-framebuffer

so that if sun7i has totally different display controller, there would
be no conflict.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/352e5782/attachment-0001.sig>
