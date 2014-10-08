From: heiner.kallweit@web.de (Heiner Kallweit)
Date: Wed, 08 Oct 2014 07:27:33 +0200
Subject: [PATCH] imx: thermal: imx_get_temp might be called before the
 sensor clock ist prepared
In-Reply-To: <CAOMZO5CctOy9d79L33Lo7n4y+_aBszT8uKiGcOzmHe-6VfVmog@mail.gmail.com>
References: <5432E14C.2090403@web.de>	<1412687071.2577.1.camel@pengutronix.de>	<543440B3.4070307@web.de>
 <CAOMZO5CctOy9d79L33Lo7n4y+_aBszT8uKiGcOzmHe-6VfVmog@mail.gmail.com>
Message-ID: <5434CB45.1040509@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, I'll submit a revised patch with improved error path.

Regards, Heiner

Am 07.10.2014 um 21:42 schrieb Fabio Estevam:
> Hi Heiner,
> 
> On Tue, Oct 7, 2014 at 4:36 PM, Heiner Kallweit <heiner.kallweit@web.de> wrote:
>> Thanks for the hint, Philipp.
>> After thinking a little bit more about it I'm not sure about one thing:
>>
>> If we can't get the clock or fail to enable it: Currently the code just throws
>> a warning and proceeds with trying to register the thermal device.
>> Does this make sense or shall we bail out instead (like in case of other error conditions
>> in imx_thermal_probe)? I'd tend to bail out ..
> 
> Agree with you. We should do a 'return ret' if clk_prepare_enable()
> fails. Thanks
> 
