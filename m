From: stefan@agner.ch (Stefan Agner)
Date: Mon, 02 Mar 2015 18:47:26 +0100
Subject: [PATCH] ARM: extend =?UTF-8?Q?SMP=5FON=5FUP=20detection=20for?=
 =?UTF-8?Q?=20A=35=20MPCore=20devices=20with=20=31=20CPU?=
In-Reply-To: <20150217161514.GA2236@afzal-ThinkPad-R50e>
References: <1422662026-12968-1-git-send-email-stefan@agner.ch>
 <20150217161514.GA2236@afzal-ThinkPad-R50e>
Message-ID: <c0ae1b7d14bd1c21472553da3a93b58f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-02-17 17:15, Afzal Mohammed wrote:
> Hi Stefan,
> 
> On Sat, Jan 31, 2015 at 12:53:46AM +0100, Stefan Agner wrote:
> 
>> On the Vybrid platform this did not lead to CPU faults (so far),
>> but is_smp checks evaluate to true which is not optimal
>> performance wise.
> 
> Just curious, was the performance difference considerable ?

I can see differences in the boot time stamps in the 10th ms range, not
sure whether this is really due to the detection of the UP system or
some side effects. I guess the change would be measurable with the right
workload, for instance the memory policies are different for SMP system
compared to UP systems.

However, we use a custom configuration for the device, hence SMP is by
default disabled anyway. But it would be nice to be able to use
multi-platform kernels without having to worry about SMP detection...

--
Stefan
