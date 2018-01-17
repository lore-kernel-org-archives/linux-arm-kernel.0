From: phil@raspberrypi.org (Phil Elwell)
Date: Wed, 17 Jan 2018 19:38:00 +0000
Subject: mmc1 timeout issue with rpi3
In-Reply-To: <6fd0ccca-e167-d010-561b-fc60ba16b2e7@orpaltech.com>
References: <5d800b63-d45d-d4e4-214c-3ebf602c79e9@orpaltech.com>
 <1059643032.72553.1516136078614@email.1und1.de>
 <5ab12aa4-57a9-55b5-ef43-43b2eac9c1b7@orpaltech.com>
 <1199109167.10232.1516213158515@email.1und1.de>
 <a05474da-039b-2fb3-2a5a-dd04910b5be2@raspberrypi.org>
 <6fd0ccca-e167-d010-561b-fc60ba16b2e7@orpaltech.com>
Message-ID: <73cb9234-8773-798f-afb7-ca7227117071@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

On 17/01/2018 18:52, Sergey Suloev wrote:
> Hi Phil
> 
> thank you for that detail. But I am using the same power supply that I have been always using for my rpi3. It worked with a raspbian image and I never had such issues.
> 
> Thanks

[ This is the "top posting" crime that Stefan was referring to. We are supposed to add comments inline
or at the end. ]

A different kernel will have different timing and current requirements. To rule out a
marginal supply, boot a standard Raspbian image and run "vcgencmd get_throttled". An
answer other than 0x0 (likely 0x50000, but possibly 0x50005) indicates that undervoltage
has occurred (and is possibly still ocurring). This may not be enough to trigger a
malfunction, but the potential is there.

Phil

> On 01/17/2018 09:47 PM, Phil Elwell wrote:
>> Hi Sergey,
>>
>> To add to Stefan's questions, have you specifically checked that your power supply
>> is adequate? Issues like this during startup are often caused by a momentary undervoltage
>> triggered by increased current demands as many subsystems are started at once. We
>> recommend a 2.5A supply for Pi 3.
>>
>> Phil
> 
