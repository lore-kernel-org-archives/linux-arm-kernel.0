From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 5 Nov 2012 23:59:07 +0530
Subject: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
In-Reply-To: <5097F642.9010803@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
 <20121105141442.GD4815@arwen.pp.htv.fi> <5097CBF1.6060108@ti.com>
 <20121105142517.GG4815@arwen.pp.htv.fi> <5097F642.9010803@ti.com>
Message-ID: <CAM=Q2csELdqM2PRtaswx7Ug6KxB+CwVakXnBY6O=FJrKkBWz6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/5/12, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 11/5/2012 3:25 PM, Felipe Balbi wrote:
>> Hi,
>>
>> On Mon, Nov 05, 2012 at 07:53:45PM +0530, Shubhrajyoti wrote:
>>> On Monday 05 November 2012 07:44 PM, Felipe Balbi wrote:
>>>>> -							dev->syscstate);
>>>>>> -		}
>>>> not sure if this will work. What about the first time you call reset()
>>>> ?
>>>> won't SYSC just contain the reset values ?
>>> No actually the hwmod sets the value.
>>
>> ahaaa, ok good. Let's get an Ack from Benoit, then.
>
> Well, in fact, I'm a little bit surprised that we still have to hack the

there was an attempt [1]

the pdata stuff may have issues with dt having to deal with more pdata [2]


> SYSC directly without using an omap_device API.

 Paul was not happy with omap device api  [3]

As far as the patch is concerned it is only getting rid of the hard coded flags
and the rev check.

> I know that we have to
> do some weird stuff for reseting that IP, but didn't we already exposed
> something to allow that?
>
> Regards,
> Benoit

[1]  http://www.spinics.net/lists/linux-i2c/msg06810.html
[2]  http://www.spinics.net/lists/linux-i2c/msg06937.html
[3] http://www.spinics.net/lists/linux-i2c/msg06943.html
