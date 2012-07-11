From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 11 Jul 2012 12:11:23 -0700
Subject: [PATCH] i2c i.MX: Fix divider table
In-Reply-To: <20120711183838.GM30009@pengutronix.de>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
 <20120705145236.GA2735@richard-laptop>
 <20120705160153.GT30009@pengutronix.de>
 <20120706005249.GA26888@b20223-02.ap.freescale.net>
 <20120706062852.GZ30009@pengutronix.de>
 <20120711060121.GB30055@b20223-02.ap.freescale.net>
 <20120711183838.GM30009@pengutronix.de>
Message-ID: <4FFDCFDB.7020402@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/11/2012 11:38 AM, Sascha Hauer wrote:
> Hi Richard,
>
> On Wed, Jul 11, 2012 at 02:01:21PM +0800, Richard Zhao wrote:
>> IC guys confirmed that the spec is right:
>>
>> This an adaptive feature of our I2C module may apply to all IMX chips.
>> No mistake in the table of RMs.
>>
>> The divider is designed to guarantee SCL high level and low level last
>> time. Divider will hold when SCL transition from 1 to 0 or 0 to 1, if
>> the transition time is longer than 1 internal pre-divided clock cycle.
>> The pre-divided clock is divided from I2C module clock, used for
>> generating SCL. So you will see SCL clock cycle is some way longer than
>> calculated value using IFDR.
>>
>> Transition time will different from rising or falling edge, different
>> pull-up resistors, and different SCL loading.
>>
>> This feature make sure transition time won?t eat both level time of SCL.
> Thanks for clarification. Does this mean that this feature is used to
> synchronize between the bus clock and and bitclock?
>
> I'll send a documentation patch for this next week to make this clear.
>
> Sascha
>
How does this explain why column 2 matched your measurements, but 1, 3, 
and 4 didn't.
And you tested on 2 different boards.
Something doesn't smell right.

Just my 2cents
Troy
