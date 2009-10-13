From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Oct 2009 13:12:14 -0400
Subject: [RFC PATCH v1] EP93XX: Add ADC support
In-Reply-To: <4AD4763C.6000403@techworks.ie>
References: <20091012142413.30881.62391.stgit@archeopterix.techworks.local>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7F6F@mi8nycmail19.Mi8.com>
	<4AD4763C.6000403@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB801E@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 13, 2009 5:45 AM, Christian Gagneraud wrote:

>>> +/*
>>> + * Touchscreen and Direct ADC:
>>> + *
>>> + * +------------------------+-----+-----+-----+-----+ 
>>> + * |ADC/TS driver in use    | n/n | y/n | n/y | y/y | 
>>> + * +------------------------+-----+-----+-----+-----+
>>> + * |SYSCON_DEVCFG_ADCPD     |  1  |  0  |  0  |  0  |
>>> + * |SYSCON_DEVCFG_TIN       |  X  |  1  |  0  | 1/0 |
>>> + * |SYSCON_KEYTCHCLKDIV_TSEN|  0  |  1  |  1  |  1  |
>>> + * |TS_SETUP_ENABLE (*)     |  0  |  0  |  1  | 0/1 |
>>> + * +------------------------+-----+-----+-----+-----+
>>> + * (*) 
>> 
>> Are you missing a comment about (*)?
>
> Yes I do, and I'm still missing it! The datasheet is so unclear that I 
> have the feeling there's something to take care of here, but I still 
> don't know what...

Yeah, the Analog Touch Screen Interface section of the User's Guide is
pretty confusing.

>> Is it the intention that this i/o wrapper will allow BOTH the adc
>> and the touchscreen to work at the same time?  I don't think that
>> is possible.

> For now there's no touchscreen driver mainline, and I don't have a 
> clear picture yet on how to make the 2 drivers collaborate. I think 
> this is doable but as all my boards are EP9302 based (which doesn't 
> have the touchscreen controller, just the ADC engine) I can't test 
> anything!
