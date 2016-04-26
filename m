From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 26 Apr 2016 13:41:23 +0200
Subject: clk: bcm2835: what is the best way to limit the selection of
 parent clocks in the device-tree
In-Reply-To: <571F4F78.6000504@i2se.com>
References: <571DCED0.9010008@martin.sperl.org> <571F4F78.6000504@i2se.com>
Message-ID: <D5D977DF-E565-4354-9212-BEE5177C6AE3@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 26.04.2016, at 13:22, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi Martin,
> 
> Am 25.04.2016 um 10:01 schrieb Martin Sperl:
>> Hi!
>> 
>> On the raspberry pi the pcm (and other) clock has multiple parent
>> clocks that the driver may select from to get the "best fit" clock.
>> 
>> This list of parents of valid for each clock is hard-coded in the driver.
>> 
>> But this "standard" list of parents includes some clocks that are
>> independently controlled by the firmware with - unfortunately for
>> now - no notification of changes going back to the linux kernel.
>> This is mostly needed for powermanagement and ARM clock
>> modifications as well as to avoid overheating.
>> 
>> So how is the best way to define those parent clocks one wants to
>> use for an individual clock?
> 
> since the device tree should describe the hardware this should be kept
> in the driver. So we can't get into trouble if the firmware change it's
> behavior.

I am just thinking about the way that different groups want to use
for example i2s may want to use different parents than pwm.

My concern is that people will have to compile the kernel separately
to reach their personal preference. And to some extend this
is also describing the device connected: different DAC may have
different preferences (with regards to noise) - and that then 
describes the hardware (or at least the intent of the HW designer).

So I wonder how we can achive this?

Along a similar line is the configuration of the higher order mash
clock options (fractional divider with noise spreading).

Making all these policies go inside the driver may not be intended,
as it would not apply to all DAC equally...

Martin
