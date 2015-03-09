From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 09 Mar 2015 19:40:56 +0100
Subject: [PATCH v5 3/8] pinctrl: cygnus: add initial IOMUX driver support
In-Reply-To: <CACRpkdYTDSSSd5oDNXmcav-2ycbki0=K+0Cm6dLSBHUv6UXF9g@mail.gmail.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-4-git-send-email-rjui@broadcom.com>
 <1425542612.24292.180.camel@x220>
 <CACRpkdYTDSSSd5oDNXmcav-2ycbki0=K+0Cm6dLSBHUv6UXF9g@mail.gmail.com>
Message-ID: <1425926456.2317.13.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij schreef op ma 09-03-2015 om 17:28 [+0100]:
> I think you're right. Or I fear you're right.
> 
> But this problem is present in so many drivers that a generic
> fixup needs to be done with a script and across an entire subsystem
> at once,

Why don't we start with checking for similar cases during review, like
I'm now doing for only a week or two?

>  and besides I'm not sure of these macros disturb so much.

I think they're confusing at best. Ie, when reading the code and the
corresponding Kconfig file one has to wonder: should the Kconfig symbol
actually be tristate or should it stay bool but did someone forget to
delete the module-specific code?

> They are documentation in a sense, albeit a kind of documentation
> we used before we had git to record the actual authors of the
> code.

They're useful, mostly, for module utilities. Outside that scope they
add information that thousands of files (that can also only be built-in
but do not have these macros) do not have and, apparently, do not need.

Thanks,


Paul Bolle
