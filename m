From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 05 Oct 2015 20:48:30 +0200
Subject: [PATCH 00/17] ARM: pxa: Use PWM lookup tables
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
 (Thierry Reding's message of "Mon, 5 Oct 2015 10:49:40 +0200")
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <87r3l9b18h.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> Back when the PWM framework was introduced the concept of PWM lookup
> tables was added to allow board code to register a table of PWM devices
> and their association with consumers. The goal is to allow drivers to
> use a unified method to request PWM devices. At the same time, since no
> boards were exposing these tables, fallback code was kept in drivers to
> allow old code to remain functional. Unfortunately I got the numbering
> of PWM devices wrong, so all these boards should now be without working
> backlight control, though only a few cases have been fixed since, so I
> guess most of this hardware is largely unused.
>
> This series aims at finally fixing this up. It converts all PXA boards
> that hook up a pwm-backlight device to use the new PWM lookup tables.
> All patches have been compile-tested, but I don't have access to any of
> these boards, so I couldn't verify that they really work.

Hi Thierry,

Thanks for this serie. I'll test it in the next days. It looks good to me, at
least the 5 patches I had a look into, so if it works on the 5 boards I have,
I'll queue it up in pxa/for-next.

Cheers.

-- 
Robert

PS: removed all the addresses at openezx.org, don't see to work, or at least
make my MTA very angry.
