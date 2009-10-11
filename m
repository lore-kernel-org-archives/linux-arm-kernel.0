From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 11 Oct 2009 17:59:45 +0200
Subject: zaurus suspend saga: 2.6.32-rc3
In-Reply-To: <20091011090423.GB1414@ucw.cz> (Pavel Machek's message of "Sun\,
	11 Oct 2009 11\:04\:23 +0200")
References: <20091011090423.GB1414@ucw.cz>
Message-ID: <87skdpvs3y.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
> I'm using patch similar to this for debugging:
>
> ...and good news is that it blinks after pressing of power button.
>
> ...core > pm_test also works.
>
> I also verified that end of pxa_pm_enter() is reached (with similar
> blinking patch). End of corgi_pxa_pm_enter() seems to be reached, too.
>
> Any ideas what to try next?
> 								Pavel

For the Mitac MIO A701 board, with a similar problem, I had :
 - removed almost all drivers (except screen and USB for control)
 - realized that the culprit was amongst drivers (which resumed in a loop in
 that time, should be the same now)
 - added some way to find which one failed (in my case, I chose morse code
 through the buzzer to "speak" the device's name)
 - found out the driver faulty code
 - fixed it
 - retried, cheered.

As soon as you reach a resumed screen, it becomes easier :)

That's a very tedious and long fight, good luck.

Cheers

--
Robert
