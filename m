From: marex@denx.de (Marek Vasut)
Date: Thu, 19 Jul 2012 11:13:29 +0200
Subject: Linux ARM with XZ compression issue
In-Reply-To: <CAJfuBxxpGqBeD1O3QfXLhHmMGBEFvy5XZOFLH6Xww33Y+7P_Ow@mail.gmail.com>
References: <201207181634.58089.marex@denx.de>
 <201207190024.50846.marex@denx.de>
 <CAJfuBxxpGqBeD1O3QfXLhHmMGBEFvy5XZOFLH6Xww33Y+7P_Ow@mail.gmail.com>
Message-ID: <201207191113.29529.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jim Cromie,

Note, try keeping the CC list please

> hi again,
> 
> On Wed, Jul 18, 2012 at 4:24 PM, Marek Vasut <marex@denx.de> wrote:
> > Dear Jim Cromie,
> > 
> >> hi Marek,
> >> 
> >> Surprising problem - is strstr the only one missing ?
> > 
> > I think so.
> > 
> >> Its only used in the stub fn, so you could cheat and
> >> just return 0, or warn less discriminately and return 0.
> >> Obviously, that wouldnt be acceptable for mainline.
> > 
> > Correct, so I'm looking for proper solution.
> 
> Ok.  I think youre on the right track - ie adding the fn.
> 
> just one more thought -
> add a strcmp call into the func, see if it compiles or breaks
> the same way.  If it breaks, theres a larger build issue,
> and Im not sure how LKML would react.

Hm, looks like strcmp is also missing, even though it's declared in

arch/arm/boot/compressed/string.c

> >> What happens if you build with compression other than XZ ?
> > 
> > LZMA is good, GZ as well.
> 
> ok, thats good -
> It suggests the problem is quite localized.
> 
> I suppose strcmp could still be missing,
> and possibly more likely, since the issue is so localized,
> and not exposed by other builds in other arches.
> 
> Do you already know where strstr should be added ?

arch/arm/boot/compressed/string.c I believe.

> Im asking cuz Im completely unfamiliar with arm,
> but did recently buy a raspberry-PI, so I'll be starting
> to hack on that eventually :-)
> 
> >> is it specific to XZ as you said, or a more general problem ?
> > 
> > Specific to XZ.
> > 

[...]

Best regards,
Marek Vasut
