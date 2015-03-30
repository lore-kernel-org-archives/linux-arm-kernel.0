From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 30 Mar 2015 15:48:08 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express
 to be removed from nightly testing
In-Reply-To: <20150330140333.GJ24899@n2100.arm.linux.org.uk>
References: <20150316093553.GF8656@n2100.arm.linux.org.uk>
 <20150316130419.GI8656@n2100.arm.linux.org.uk> <55071742.6000405@arm.com>
 <20150316181634.GK8656@n2100.arm.linux.org.uk> <55072BF5.7030901@arm.com>
 <20150316195255.GM8656@n2100.arm.linux.org.uk> <550818A6.9020205@arm.com>
 <20150317153657.GY8656@n2100.arm.linux.org.uk> <55084D99.7050004@arm.com>
 <20150317161748.GZ8656@n2100.arm.linux.org.uk>
 <20150330140333.GJ24899@n2100.arm.linux.org.uk>
Message-ID: <55196228.5050805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 30/03/15 15:03, Russell King - ARM Linux wrote:
> On Tue, Mar 17, 2015 at 04:17:48PM +0000, Russell King - ARM Linux wrote:
>> On Tue, Mar 17, 2015 at 03:51:53PM +0000, Sudeep Holla wrote:
>>> That's bad. I started with 2 cycles for all(rd/wr/setup) latencies(data
>>> and tag ram) and narrowed down to this setting with multiple
>>> experiments. I did try booting 10 times each time at-least.
>>>
>>> Since the bootmon sets 8 cycles for all the latencies, does it make
>>> sense to try that setting to check if the issue you are seeing is
>>> related to L2 latencies at all. Meanwhile I will continue my testing.
>>
>> For me <2 2 1> works - so read and write latencies of 2, setup of 1.
>
> So what's happening?  Is someone going to update the dtb to adjust the
> latencies so that we can have a reliable platform?
>

Though <2 2 1> works fine most of the time, I did try testing continuous
reboot overnight and it failed. I kept increasing the latencies and
found out that even max latency of <8 8 8> could not survive continuous
overnight reboot test and it fails with exact same issue.

So I am not sure if we can consider it as a fix. However if we are OK to
have *mostly reliable*, then we can push that change.

Regards,
Sudeep
