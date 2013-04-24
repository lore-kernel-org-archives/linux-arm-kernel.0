From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 24 Apr 2013 22:28:47 +0200
Subject: [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan
 controller
In-Reply-To: <20130424133856.GA18851@roeck-us.net> (Guenter Roeck's message of
 "Wed, 24 Apr 2013 06:38:56 -0700")
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
 <20130424053758.GC8710@lunn.ch> <87obd4wb4e.fsf@natisbad.org>
 <20130424133856.GA18851@roeck-us.net>
Message-ID: <87li878ygw.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Guenter Roeck <linux@roeck-us.net> writes:

>> > You could consider using regmap for holding this cache.
>> >
>> > http://elceurope2012.sched.org/event/100619b669ce5767341624253aa03659?iframe=no&w=900&sidebar=yes&bg=no#.UXdspHLQ5jM
>> >
>> > http://elinux.org/ELCE_Europe_2012_Presentations
>> 
>> Interesting. As I am not yet familiar w/ regmap I would prefer having
>> the driver accepted during merge window with current data structure and
>> then convert it to regmap. But I will take a look (e.g. will study
>> fca1dd03 for instance). Thanks for the pointers. 
>> 
> I have not had time for a detailed review, but adding regmap support
> will not be a requirement.
>
> Note that it is too late for 3.10, so the driver will have to wait for
> 3.11.

Well, I think I can live with it; The only bad thing is that it kills my
excuses not to spend time on regmap ;-)


>> >> +/*
>> >> + * Helpers to import hardware characteristics from .dts file and overload
>> >> + * default config values.
>> >> + */
>> >> +
>> >> +#ifdef CONFIG_OF
>> >
>> > Can the driver be used without device tree? Would it be simpler to
>> >  just add depends OF in the Kconfig entry?
>> 
>> It can be used if the default params (or those configured by u-boot I
>> guess) fit your needs. I think it would be fairly easy to extend the
>> driver later to expose g762_config struct to allow parameters to be set
>> w/o using OF. If someone wants to do that, I think it is better to not
>> depend on OF in Kconfig at the moment but I have not strong argument
>> other that that one. I'll let you decide.
>> 
> Agreed. As long as there are major platforms not supporting device tree,
> and as long as device tree overlays are not supported, it must not be made
> mandatory. Especially for I2C and SPI devices I reserve the right to be able
> test the hardware on an X86 system and not require a reboot to do so.

Understood. Following Simon's post, I think it's useful to implement
some init function for non DT-enabled platforms. 

a+
