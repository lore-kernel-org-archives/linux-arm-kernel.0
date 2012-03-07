From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Mar 2012 09:40:31 +0100
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <alpine.LFD.2.02.1203061146210.31242@xanadu.home>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201202281945.39419.arnd@arndb.de>
 <alpine.LFD.2.02.1203052035170.31242@xanadu.home>
 <201203061412.00073.arnd@arndb.de>
 <alpine.LFD.2.02.1203061146210.31242@xanadu.home>
Message-ID: <CACRpkdYQpnSMVWUizEYHTjx_AK5Ai7dos0SBd208Wf5ZJLdrCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 5:51 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 6 Mar 2012, Arnd Bergmann wrote:
>> Interestingly, that leaves ixp4xx as the only big-endian ARM platform.
>> I believe that ixp4xx is still being actively used quite a bit, but does
>> that include the big-endian ones? There is no immediate reason why we
>> would want to drop support for big-endian, but if it's not used at all,
>> that would be an interesting cleanup opportunity.
>
> The NSLU2 is (was) a quite popular NAS device and it is used in big
> endian by default.
>
> The BE support isn't getting in the way of anything, so there is no
> reason to remove it, even if it isn't being used much.

Network equipment seems to like using BE.

I have some vague idea that this is beacuse IP packets are big
endian, and thus you can process them quickly by just casting fields
to e.g. u32 pointers and read them.

I don't know if this is true, but seems to much of a correlation to
be pure coincidence. Thus a pretty interesting subject in
embedded ARM not used for tablets/mobile/generic computing
kind of stuff.

Yours,
Linus Walleij
