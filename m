From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Jan 2013 13:52:57 -0800
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <50FEE175.90504@linaro.org>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <20130121232322.GK15361@atomide.com> <50FE307F.9000701@ti.com>
 <201301220931.24570.arnd@arndb.de> <50FE666B.10902@ti.com>
 <20130122145113.GK23505@n2100.arm.linux.org.uk>
 <50FEE175.90504@linaro.org>
Message-ID: <20130122215257.GU22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* John Stultz <john.stultz@linaro.org> [130122 11:02]:
> 
> Correct, with HRT, we actually trigger the HZ-frequency timer tick
> from an hrtimer (which expires based on the system time driven by
> the clocksource). Thus even if there is a theoretical error between
> the ideal HZ and what the hardware can do, that error will not
> propagate forward.

If there's no cumulative error, sounds like the way to go is to select
HRT for ARM multiplatform builds and set the HZ to 100 then.

Regards,

Tony
