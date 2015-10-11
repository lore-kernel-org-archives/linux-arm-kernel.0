From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 11 Oct 2015 21:59:24 +0200
Subject: [PATCH v4 00/26] ARM: pxa: magician: Rework HTC Magician support
In-Reply-To: <87si5h7r2t.fsf@belgarion.home> (Robert Jarzmik's message of
 "Sun, 11 Oct 2015 10:22:02 +0200")
References: <5609AB45.9030009@tul.cz>
 <20151006152527.GA32352@xo-6d-61-c0.localdomain>
 <56172F88.2060602@tul.cz> <87si5h7r2t.fsf@belgarion.home>
Message-ID: <87oag56usj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Petr Cvek <petr.cvek@tul.cz> writes:
>
>>> Thanks (a pozdrav :-),
>>> 
>>> 								Pavel
> Hi Petr,
>
> I'll start applying part of this serie today evening (my evening).
> All Philipp's acked patches for a start.
>
> For the minor changes required by Philipp (comments, ...), if you just state by
> mail that you agree I'll make them inline before applying.
>
> Cheers.
>
> --
> Robert
Ok, applied and pushed out in pxa/for-next
    https://github.com/rjarzmik/linux.git pxa/for-next :

425c97c3c937 ARM: pxa: magician: Move platform_add_devices() to the end of magician_init()
3b1c0c4ae8fd ARM: pxa: magician: Add missing regulator for PWM backlight
452f1945c9b7 ARM: pxa: magician: Add debug message for backlight brightness function
20c1c7bb35c2 ARM: pxa: magician: Remove definition of the STUART port
3181b4a3815d ARM: pxa: magician: Fix wrongly enabled USB host ports
ba79d845999d ARM: pxa: magician: Fix support for Intel Strata NOR Flash
d62591e4e5d1 ARM: pxa: magician: Fix redundant GPIO request for pxaficp_ir
d73219de5868 ARM: pxa: magician: Fix platform data for both PXA27x I2C controllers
48e112eb54eb ARM: pxa: magician: Fix and add charging detection functions
65cd6cc24910 ARM: pxa: magician: Optimize Samsung LCD refresh to 50Hz
c85c66dbc212 ARM: pxa: magician: Rename charger cable detection EGPIOs
6fd9d402d8c4 ARM: pxa: magician: Optimize powerup delays for Samsung LCD
e391a4d95dd4 ARM: pxa: magician: Rename abstract LCD GPIOs
32bed563d51f ARM: pxa: magician: Add new discovered EGPIO pins
ab558b6c5834 ARM: pxa: magician: Change description of LCD power GPIO
c1ed9f57e853 ARM: pxa: magician: Optimize debug messages for LCD power
33e910e79b77 ARM: pxa: magician: Print more specific error message for global GPIOs
4c006b908a07 ARM: pxa: magician: Fix indentation in machine files

That leaves out 8 patches, for you to :
 - either resubmit (rebased on top of the pxa/for-next tree)
 - or drop (mostly because of Philipp's NACK or the camera reset)

This way your next submission should be quite shorter and easy to manage.

Cheers.

-- 
Robert
