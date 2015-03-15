From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Mar 2015 13:08:19 +0100
Subject: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
In-Reply-To: <CAB3XZEdFMQexA69JEuw=VnqsNOEkWAM0+oWWmt6DaN9+hZ+vdw@mail.gmail.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <20150313151301.GJ5264@atomide.com>
 <CAB3XZEdFMQexA69JEuw=VnqsNOEkWAM0+oWWmt6DaN9+hZ+vdw@mail.gmail.com>
Message-ID: <2070859.WcMooC33YH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 March 2015 10:50:42 Eliad Peller wrote:
> yeah, i missed it :/
> 
> looks like there's no platform that defines platform data for it.
> i'll replace the dev_get_platdata() with a function that only parses
> the clock-frequency properties (the irq is taken in this case from the
> spi_device).
> (or maybe i should just drop it, as no one actually uses it?)

I don't think we should drop the driver, but dropping the platform_data
support sounds reasonable. New users of this driver should all be using
DT, and if there is a good reason to use platform_data, it's easily
put back.

	Arnd
