From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 18 Jan 2015 14:18:24 -0800
Subject: [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
In-Reply-To: <20150118203346.GA29863@amd>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
 <CANOLnON6rAQ2+jJEFDKseH2Htu6bqRkURDioGt7zp1Ze73f8Pw@mail.gmail.com>
 <CAGo_u6qO0ok+GBnm7SQtw6dJuwGN2OuP7CpKDEWawS3V2go4KA@mail.gmail.com>
 <20141229181556.GA26926@amd> <20141229190448.GA27124@roeck-us.net>
 <20150103091858.GA30538@amd> <20150107161944.GB9012@roeck-us.net>
 <20150118203346.GA29863@amd>
Message-ID: <54BC3130.4010401@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2015 12:33 PM, Pavel Machek wrote:

>>>> Pavel,
>>>>
>>>> can you look into the omap4 thermal driver to see if it can be used ?
>>>
>>> After some fixes... yes, it seems to be same hardware.
>>>
>> So this should be the way to go, but then we have others claim that
>> it should not be done because the OMAP3 sensors are too unreliable
>> to use for thermal decisions. Not really sure where that leaves us.
>> I am kind of opposed to have similar drivers for similar chips
>> in two different subsystems.
>>
>> Is it possible to add the patch below to the omap thermal driver
>> and not use it for thermal decisions ?
>
> Well... noone forces you to enable the driver, and I don't think it
> will do any thermal decisions on N900 as it is ... so we should be ok.
>
> Plus, it seems to work reasonably well (say +- 5 C), so situation does
> not seem to be as bad as TI claims.
>
> Nokia was actually using it in production.
>
Ok, I'll assume that omap3 support will be added to the omap thermal driver.

Thanks,
Guenter
