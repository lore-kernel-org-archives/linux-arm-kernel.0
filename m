From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 6 Jul 2015 15:12:27 +0200
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <20150706123126.GG10705@atomide.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <201507061423.23505@pali> <20150706123126.GG10705@atomide.com>
Message-ID: <201507061512.27124@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 July 2015 14:31:27 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [150706 05:25]:
> > into which file should I put documentation about new DT properties?
> 
> If it's Linux generic like linux,revision, then how about
> Documentation/devicetree/bindings/revision.txt?
> 
> For the ATAGs, Documentation/devicetree/bindings/arm/atag.txt?
> 
> Regards,
> 
> Tony

Hm... now I'm thinking into which DT field should I put atags and 
revision. In previous emails you wrote to use "linux,atags", now 
"arm,atags"? And put them into root node? Or other?

In arch/arm/boot/compressed/atags_to_fdt.c code I see that most atag 
properties are converted into "/chosen" node in DT...

So what do you prefer for "revision" and what for "atags"?

Some mentioned examples:

"/revision"
"/chosen/revision"
"/linux,revision"
"/chosen/linux,revision"
...

"/atags"
"/chosen/atags"
"/linux,atags"
"/chosen/linux,atags"
"/arm,atags"
"/chosen/arm,atags"
...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/a874ec87/attachment.sig>
