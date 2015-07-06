From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 6 Jul 2015 18:20:35 +0200
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <CAL_Jsq+ysDqxTgfW1JvG5czHa4UkZQDv1BN63iK4jvV9kDXM8w@mail.gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <201507061512.27124@pali>
 <CAL_Jsq+ysDqxTgfW1JvG5czHa4UkZQDv1BN63iK4jvV9kDXM8w@mail.gmail.com>
Message-ID: <201507061820.35789@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 July 2015 17:22:58 Rob Herring wrote:
> On Mon, Jul 6, 2015 at 8:12 AM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> > On Monday 06 July 2015 14:31:27 Tony Lindgren wrote:
> >> * Pali Roh?r <pali.rohar@gmail.com> [150706 05:25]:
> >> > into which file should I put documentation about new DT
> >> > properties?
> >> 
> >> If it's Linux generic like linux,revision, then how about
> >> Documentation/devicetree/bindings/revision.txt?
> >> 
> >> For the ATAGs, Documentation/devicetree/bindings/arm/atag.txt?
> >> 
> >> Regards,
> >> 
> >> Tony
> > 
> > Hm... now I'm thinking into which DT field should I put atags and
> > revision. In previous emails you wrote to use "linux,atags", now
> > "arm,atags"? And put them into root node? Or other?
> > 
> > In arch/arm/boot/compressed/atags_to_fdt.c code I see that most
> > atag properties are converted into "/chosen" node in DT...
> > 
> > So what do you prefer for "revision" and what for "atags"?
> > 
> > Some mentioned examples:
> > 
> > "/revision"
> 
> This one. This is a top level h/w property.
> 
> > "/chosen/revision"
> > "/linux,revision"
> > "/chosen/linux,revision"
> > ...
> > 
> > "/atags"
> > "/chosen/atags"
> > "/linux,atags"
> > "/chosen/linux,atags"
> 
> This one. ATAGs are a Linux data struct.
> 
> Rob
> 

Ok, and how read that property "/chosen/linux,atags" in function
setup_machine_fdt() from file arch/arm/kernel/devtree.c ?

of_get_flat_dt_prop() cannot be used unless somebody get me offset to
node "/chosen"...

Any idea?

> > "/arm,atags"
> > "/chosen/arm,atags"
> > ...
> > 
> > --
> > Pali Roh?r
> > pali.rohar at gmail.com


-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/4b4fe11c/attachment-0001.sig>
