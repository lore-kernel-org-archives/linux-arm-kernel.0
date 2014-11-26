From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 26 Nov 2014 10:13:39 +0200
Subject: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb
 extensions
In-Reply-To: <5474880F.8040908@redhat.com>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
 <547476DA.2030004@ti.com> <54747B72.1050406@redhat.com>
 <54747DCF.9010502@ti.com> <5474824F.8080000@redhat.com>
 <5474863A.5040801@ti.com> <5474880F.8040908@redhat.com>
Message-ID: <54758BB3.9090008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/14 15:45, Hans de Goede wrote:

>> Wouldn't
>>
>> compatible = "allwinner,sun4i-simple-framebuffer", "simple-framebuffer";
>>
>> tell that it's a simple-framebuffer, with allwinner's sun4i extensions?
>>
>> I guess you can have just "allwinner,simple-framebuffer", and then if a
>> new Allwinner SoC has a totally different display controller, the
>> documentation would specify that this property is for that SoC, and this
>> another property is for that another SoC. But isn't the compatible
>> string what's supposed to use in cases like this?
> 
> The only soc specific thing in the binding is the pipeline property string
> values, and we can always add new values to that, the rest is all generic,
> as simplefb is generic.

The thing I don't understand is that the compatible string states that
"this covers all Allwinner SoCs", even if we have no idea what kind of
SoCs those may be. And if it covers all kinds of SoCs, then it might as
well be fully generic, not Allwinner specific.

And if it's not fully generic, then having it cover all possible
Allwinner SoCs doesn't make sense either.

> As said Ian Campbell, Grant and me have decided on using this, and
> currently
> patches are already queued up for both the dts files and u-boot to use
> this,
> so unless there are really strong reasons to change it at this point I
> would
> prefer to keep this as is.

Ok. Well, as I said, it does not look correct to me, but if everybody
else agrees on it (and I see I didn't get any replies during the night),
I'll be applying this today.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/1f5ca4bb/attachment.sig>
