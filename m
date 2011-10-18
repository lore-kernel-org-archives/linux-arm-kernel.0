From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 18 Oct 2011 16:45:51 -0200
Subject: Warning at kernel/mutex.c
In-Reply-To: <20111018184008.GI21504@pengutronix.de>
References: <CAOMZO5AR4iiktjmjzUU3AbQmYVk4wE28+KrZckt=VXLBJzXdBA@mail.gmail.com>
	<20111018173744.GQ21648@n2100.arm.linux.org.uk>
	<CAOMZO5BKTzeV0f0=frQT-4uHESh2-cEQtc2UzniFT6dVSi_0EQ@mail.gmail.com>
	<20111018184008.GI21504@pengutronix.de>
Message-ID: <CAOMZO5CayjCM7FkdfHxbnyhC9d+7QTODqmNr7_xFPwkLRo8rmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/18 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

>> ?static LIST_HEAD(clocks);
>> ?static DEFINE_MUTEX(clocks_mutex);
>> +static DEFINE_SPINLOCK(clock_lock);
> If clocks_mutex is unused now, please remove it. If it's not unused you
> probably introduced a problem with your patch.

clocks_mutex is still used in clk_set_rate and clk_set_parent.

Should it be converted to spinlocks too?
