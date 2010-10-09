From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 9 Oct 2010 14:59:45 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <201010091311.26335.arnd@arndb.de>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimtdV8THgnQL1RxaqLzCUwO27AZSMPi=UtgpML7@mail.gmail.com>
	<201010091311.26335.arnd@arndb.de>
Message-ID: <AANLkTimDd10oj=rruYcB=qTaWWMAJvSCQAJNi+nQqzp7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/9 Arnd Bergmann <arnd@arndb.de>:
> On Saturday 09 October 2010 12:28:19 Felipe Contreras wrote:
>> Also, what do you think is the right attitude? Do you think all
>> driver writers should follow each and every patch on the mailing list
>> or always try release candidates? Even if they all did (some do),
>> there's no generic solution, so they all are scratching their heads
>> about how to solve this. It might be crystal clear for you how such
>> generic solution could be implemented, or perhaps how some of these
>> drivers can be fixed individually, if so, why don't you come with a
>> proposal to mitigate the pain of fixing such drivers.
>
> Please put this into perspective, it's not like this was ever a
> normal thing to do, and drivers doing an ioremap on kernel memory
> would typically not make it through a review. I've looked through
> the ARM specific drivers that do ioremap and practically all of
> them just map their MMIO registers as they should.
>
> The few drivers that may be hit by this are typically in drivers/staging
> exactly because issues like this have not been fixed yet.
>
> We should probably just fix the non-staging drivers that are hit by
> this now and declare the issue done.
>
> When you say that "many drivers broken", can you list the ones you know
> about? It would probably help resolve this the right way.

I know of tidspbridge, in my original mail I listed some links, one
which mentions: sh_mobile_ceu_camera, maybe i.MX31 users of the
mx3_camera driver: pcm037 and mx31moboard.

http://article.gmane.org/gmane.linux.ports.sh.devel/8560


>From bogus@does.not.exist.com  Sat Oct  9 07:11:57 2010
From: bogus@does.not.exist.com ()
Date: Sat, 09 Oct 2010 11:11:57 -0000
Subject: No subject
Message-ID: <mailman.0.1286625591.18522.linux-arm-kernel@lists.infradead.org>

Other people have been asking questions without mentioning specific drivers too:
http://www.spinics.net/lists/linux-fbdev/msg01745.html

But my guess is that most of the issues would be found after releasing
.36, and of course the current issues cannot possibly be fixed in that
time-frame.

Anyway, Russell said he already reverted the change, which I don't
think is ideal, we need the warning, then I think many more will pop
up.

-- 
Felipe Contreras
