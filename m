From: carlo@caione.org (Carlo Caione)
Date: Wed, 1 Mar 2017 19:45:50 +0100
Subject: [PATCH] hwmon: (scpi) Add slope and offset to SCP sensor readings
In-Reply-To: <20170301175618.GB15246@roeck-us.net>
References: <20170301132028.25309-1-carlo@caione.org>
 <41f19cd3-5086-1da9-915a-8987cfc119f9@roeck-us.net>
 <CAL9uMOG5qEgyGTue=n7abbFROKGBpUrWDOPi5_bEDUWuiHEUKg@mail.gmail.com>
 <87inntorz7.fsf@e105922-lin.cambridge.arm.com>
 <20170301175618.GB15246@roeck-us.net>
Message-ID: <CAOQ7t2Y1=fL9a4A_gPtvrrWR_uOOP_gGT-61Q+1B39t2gRJBmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 1, 2017 at 6:56 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Mar 01, 2017 at 04:57:00PM +0000, Punit Agrawal wrote:

>> Another way to fix this would be to add optional properties to the scpi
>> sensors binding and use them instead. This could then be used to fixup
>> values reported to both thermal and hwmon.
>>
>
> Yes, this would be much more appropriate.

What about something like:

sensor-coefficients = <x1 y1 z1>,
                                  <x2 y2 z2>,
                                  ...;

Where in general `x` is the sensor-id, `y` the slope and `z` the
offset for the sensor reading.
So the reported reading to hwmon (and thermal for temperature) for
sensor with id `x1` is `y1 * val + z1`, the same for sensor with id x2
and so on for all the sensors in the array.

-- 
Carlo Caione
