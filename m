From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 9 Jul 2013 12:27:41 +0200
Subject: [PATCH v2 1/5] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
In-Reply-To: <20130709092917.GO27646@sirena.org.uk>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
 <20130708150721.GK27646@sirena.org.uk>
 <CACQ1gAgJyTSdxAKK7uwG-ybE2ddC90podM3+tOAqQwZUspsU8Q@mail.gmail.com>
 <20130709092917.GO27646@sirena.org.uk>
Message-ID: <CACQ1gAi6C8A-=sONar7jiXWbJM9_x_MGkFh--wD9fH97bV+YJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/9 Mark Brown <broonie@kernel.org>:
> On Tue, Jul 09, 2013 at 10:19:45AM +0200, Richard Genoud wrote:
>> 2013/7/8 Mark Brown <broonie@kernel.org>:
>
>> > The obvious question here is of course if we can use the same driver for
>> > both of them.
>
>> I haven't got a g20 to test that, but that's the goal.
>
> I think I do somewhere.
>
>> For now, g20 is still non-DT, so I think it's best to have a DT-only
>> driver like this one for the 9x5 family (9g15, 9g25, 9x25, 9g35,
>> 9x25).
>> When the g20 will move to DT completely, we can drop sam9g20_wm8731.c
>> and adjust sam9x5_wm8731.c (mainly master clock and widgets it seems)
>> By the way, maybe g45 could use that also (and SAMA5 ?)
>
> If this is the goal then this driver needs a more generic name.
Hum. I guess we could call it atmel-ssc-sound.c, since the ultimate
goal would be to make it codec agnostic, but there's quite some work
to achieve that (handle the widgets, mclk and rates by DT).
But I really don't know if it's better to keep this name as long as
g20 is not supported, and change it after or have a name that is not
reflecting what the machine driver is doing right now.
Maybe Bo or Nicolas can give their feeling on that (since I'm not
Atmel, I don't know every SoC or what their Big Plan is for sound
machine drivers)

Richard.

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
