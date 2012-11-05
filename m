From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 5 Nov 2012 18:24:18 +0100
Subject: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
In-Reply-To: <20121105142517.GG4815@arwen.pp.htv.fi>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
 <20121105141442.GD4815@arwen.pp.htv.fi> <5097CBF1.6060108@ti.com>
 <20121105142517.GG4815@arwen.pp.htv.fi>
Message-ID: <5097F642.9010803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/5/2012 3:25 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Nov 05, 2012 at 07:53:45PM +0530, Shubhrajyoti wrote:
>> On Monday 05 November 2012 07:44 PM, Felipe Balbi wrote:
>>>> -							dev->syscstate);
>>>>> -		}
>>> not sure if this will work. What about the first time you call reset() ?
>>> won't SYSC just contain the reset values ?
>> No actually the hwmod sets the value.
>
> ahaaa, ok good. Let's get an Ack from Benoit, then.

Well, in fact, I'm a little bit surprised that we still have to hack the 
SYSC directly without using an omap_device API. I know that we have to 
do some weird stuff for reseting that IP, but didn't we already exposed 
something to allow that?

Regards,
Benoit
