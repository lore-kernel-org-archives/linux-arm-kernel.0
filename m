From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 05 May 2016 21:14:40 +0200
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <20160504162200.GX6292@sirena.org.uk> (Mark Brown's message of
 "Wed, 4 May 2016 17:22:00 +0100")
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <20160503162938.GT6292@sirena.org.uk> <87twiforl3.fsf@belgarion.home>
 <20160504162200.GX6292@sirena.org.uk>
Message-ID: <87lh3opba7.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Tue, May 03, 2016 at 09:43:20PM +0200, Robert Jarzmik wrote:
>
>> You probably mean the BITCLK clock.
>
>> What is a bit pesky about this clock is that it can either be mastered by
>> digital controller and the codec is a slave, or the other way around.
>
> That's a bit surprising - I've never encountered a system that
> impelemnts this, it may be permitted by the spec but it's always the
> CODEC.  The master clock from the CODEC is often provided by the SoC but
> I've not seen systems where anything other than the CODEC drives the
> actual AC'97 bus.

Ok, so let's assume a one direction. I'll have a look how I could add this clock
to the probe() exactly as amba_probe() does.

> It's not really adding anything though, it's just clumsy wording on
> their part - it's not like we need to distinguish this from analogue
> or any other type of AC'97 controllers.
>
>> Now if you prefer "ac97_controller" or something like that, that's as you wish,
>> the name does not matter that much to me ;)
>
> Yes.
Okay, let me add this to my todo list for v2.
I already have suspend/resume/pm_suspend/pm_resume.

Cheers.

-- 
Robert
