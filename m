From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 25 Nov 2014 15:38:02 +0200
Subject: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb
 extensions
In-Reply-To: <5474824F.8080000@redhat.com>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
 <547476DA.2030004@ti.com> <54747B72.1050406@redhat.com>
 <54747DCF.9010502@ti.com> <5474824F.8080000@redhat.com>
Message-ID: <5474863A.5040801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/14 15:21, Hans de Goede wrote:

>> Shouldn't the compatible then be "allwinner,sunxi-simple-framebuffer",
>> to differentiate from some other SoC Allwinner has or might create in
>> the future? That is, presuming you're confident enough that a single
>> compatible string covers all the current and forthcoming sunxi SoCs.
> 
> This was discussed in an earlier thread, we (Ian Campbell, Grant and me)

Okay. Sorry for not having time at the moment to follow the discussions
properly. =)

> decided to settle on allwinner,simple-framebuffer to make it clear that
> these are allwinner extensions to the standard simple-framebuffer bindings,
> and that the node otherwise is simple-framebuffer compatible.
> 
> We were afraid that e.g. sun4i-simple-framebuffer would signal that it
> is not a normal simple-framebuffer node, so we decided to go with just
> the allwinner, prefix to indicate that it uses allwinner specific
> extensions.

Wouldn't

compatible = "allwinner,sun4i-simple-framebuffer", "simple-framebuffer";

tell that it's a simple-framebuffer, with allwinner's sun4i extensions?

I guess you can have just "allwinner,simple-framebuffer", and then if a
new Allwinner SoC has a totally different display controller, the
documentation would specify that this property is for that SoC, and this
another property is for that another SoC. But isn't the compatible
string what's supposed to use in cases like this?

And if the new SoC is not sunxi, but some totally other family, there's
need for a new compatible string anyway, as
"simple-framebuffer-sunxi.txt" is for sunxi only.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/95e89780/attachment.sig>
