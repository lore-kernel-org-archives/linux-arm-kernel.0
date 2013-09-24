From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Tue, 24 Sep 2013 12:55:19 +0200
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
Message-ID: <52416F97.802@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

apologies for picking up a topic that's more than 360 days old...

We're in the position where we'd like to have FDT support just because 
it simplifies our code a whole lot; yet we want to be able to run such a 
kernel on older u-boots (completely unaware of FTDs) as well.
I believe this must be a very common use case indeed.
So a dtbuImage.<dtb> would be very useful in this case.

If I understand it correctly, dtbImage.<dtb> is indeed just a cat of 
zImage+dtb, whereas dtbuImage.<dtb> is the uimage of such a dtbImage.<dtb>.
So it shouldn't be such a crazy idea to create a dtbuImage.<dtb> within 
Kbuild (as opposed to from an external wrapper for make).

Is there any reason why nothing like that was ever mainlined?
Or maybe I'm just missing something?

Thanks!
Gerlando

On 09/27/2012 11:08 AM, Richard Genoud wrote:
> 2012/9/27 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>>> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> as discuss with Grant no this is a temporary solution so no Makefile Target
>>
>> so nack
>
> hum, it doesn't seems to be temporary on powerpc.
> cf 25431333813686654907ab987fb5de10c10a16db
> and
> ARCH=powerpc make help
>
> So what's the problem on arm ?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
