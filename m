From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Tue, 18 Apr 2017 13:23:28 +0300
Subject: [PATCH] i2c: designware: do not show SDA hold time warning when
 not needed
In-Reply-To: <20170418095939.68788787@free-electrons.com>
References: <1492203192-28025-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1492502087.24567.47.camel@linux.intel.com>
 <20170418095939.68788787@free-electrons.com>
Message-ID: <7b011e1e-8fa3-07c4-6688-5e258fd64dbd@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2017 10:59 AM, Thomas Petazzoni wrote:
> Hello,
>
> On Tue, 18 Apr 2017 10:54:47 +0300, Andy Shevchenko wrote:
>> On Fri, 2017-04-14 at 22:53 +0200, Thomas Petazzoni wrote:
>>> When the I2C controller IP block has a revision too old to be able to
>>> configure the SDA hold time, the driver currently displays a
>>> warning. However, it does so unconditionally, even if no SDA hold time
>>> has been configured through the Device Tree. This causes useless
>>> warnings when running the system, so only show the warning if a SDA
>>> hold time was specified.
>>
>> As far as I understand the warning it would be better to keep it in
>> either way, though you may shift it to debug level.
>>
>> Wolfram, Jarkko, thoughts?
>
> Why show a message when the user has not requested a custom SDA hold
> time? Getting a warning about something you haven't requested seems
> really odd.
>
> I think it makes a lot more sense to keep it at the warning level
> (because it's important to get this message if you configure a custom
> SDA hold time), but only show it when appropriate.
>
I guess warning over debug level could have slightly better chance to 
prevent someone not adding needless "i2c-sda-hold-time-ns" property in a 
hardware that doesn't support SDA hold time. But needless spamming have 
negative value so this is worth to fix. (I would do this as a single 
liner by else if ()).

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
