From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:14:37 +0000
Subject: [PATCH 0/24] Update clocksource registration
Message-ID: <20101213191437.GN8665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John Stultz notes in his commit:

    clocksource: Add clocksource_register_hz/khz interface

    How to pick good mult/shift pairs has always been difficult to
    describe to folks writing clocksource drivers, since it requires
    careful tradeoffs in adjustment accuracy vs overflow limits.

    Now, with the clocks_calc_mult_shift function, its much
    easier. However, not many clocksources have converted to using that
    function, and there is still the issue of the max interval length
    assumption being made by each clocksource driver independently.

    So this patch simplifies the registration process by having
    clocksources be registered with a hz/khz value and the registration
    function taking care of setting mult/shift.

    This should take most of the confusion out of writing a clocksource
    driver.

    Additionally it also keeps the shift size tradeoff (more accuracy vs
    longer possible nohz times) centralized so the timekeeping core can
    keep track of the assumptions being made.

This patch series updates all ARM platforms clocksource registration
to use the new clocksource_register_hz()/clocksource_register_khz()
functions, simplifying the selection of the multiply/shift constants.
