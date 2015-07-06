From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Jul 2015 06:55:06 -0700
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <201507061512.27124@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <201507061423.23505@pali> <20150706123126.GG10705@atomide.com>
 <201507061512.27124@pali>
Message-ID: <20150706135506.GI10705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150706 06:14]:
> On Monday 06 July 2015 14:31:27 Tony Lindgren wrote:
> > * Pali Roh?r <pali.rohar@gmail.com> [150706 05:25]:
> > > into which file should I put documentation about new DT properties?
> > 
> > If it's Linux generic like linux,revision, then how about
> > Documentation/devicetree/bindings/revision.txt?
> > 
> > For the ATAGs, Documentation/devicetree/bindings/arm/atag.txt?
>
> Hm... now I'm thinking into which DT field should I put atags and 
> revision. In previous emails you wrote to use "linux,atags", now 
> "arm,atags"? And put them into root node? Or other?
> 
> In arch/arm/boot/compressed/atags_to_fdt.c code I see that most atag 
> properties are converted into "/chosen" node in DT...
> 
> So what do you prefer for "revision" and what for "atags"?

I'd prefer linux,revision and arm,atags. Chances are the ATAGs
won't be used on other architectures. I'm find with linux,atags
too if people prefer that.

Regards,

Tony
 
> Some mentioned examples:
> 
> "/revision"
> "/chosen/revision"
> "/linux,revision"
> "/chosen/linux,revision"
> ...
> 
> "/atags"
> "/chosen/atags"
> "/linux,atags"
> "/chosen/linux,atags"
> "/arm,atags"
> "/chosen/arm,atags"
> ...
> 
> -- 
> Pali Roh?r
> pali.rohar at gmail.com
