From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 01 Nov 2016 20:55:10 +0100
Subject: [PATCH 5/9] ASoC: pxa: switch to new ac97 bus support
In-Reply-To: <87bmy029tu.fsf@belgarion.home> (Robert Jarzmik's message of
 "Mon, 31 Oct 2016 09:37:17 +0100")
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-6-git-send-email-robert.jarzmik@free.fr>
 <87bmy029tu.fsf@belgarion.home>
Message-ID: <8737jb0ych.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>
>> Switch to the new ac97 bus support in sound/ac97 instead of the legacy
>> snd_ac97 one.
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> I realized this one impacts sound/arm/pxa2xx-ac97.c.
> This deserves a v2, with this patch being split into 2 pieces :
>  - one for pxa2xx-ac97-lib.*
>  - one which will be the true switch to the new ac97 bus.

And as another consequence, all pxa ac97 based codecs should be converted. So
far, machine drivers in sound/soc/pxa/*.c using ac97 all use either wm9705,
wm9712 or wm9713.

Therefore for this patch to be usable, I must also convert wm9705 and wm9712.

Cheers.

-- 
Robert
