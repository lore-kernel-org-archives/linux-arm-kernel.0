From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 13 May 2014 23:31:54 +0200
Subject: [PATCH 1/2] clk: of: helper for determining flags properties
In-Reply-To: <20140513204924.5943.24086@quantum>
References: <1399982253-21079-1-git-send-email-gabriel.fernandez@linaro.org>
 <1399982253-21079-2-git-send-email-gabriel.fernandez@linaro.org>
 <20140513122054.GA2419@e106331-lin.cambridge.arm.com>
 <5372363B.4080608@gmail.com> <20140513204924.5943.24086@quantum>
Message-ID: <53728F4A.6050303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 10:49 PM, Mike Turquette wrote:
> Quoting Sebastian Hesselbarth (2014-05-13 08:11:55)
>> On 05/13/2014 02:20 PM, Mark Rutland wrote:
>>> You've also failed to document the property.
>>>
>>> What are you trying to achieve here, and why do you think this is the
>>> best way of achieving that?
>>
>> I cannot tell from the commit msgs, but consider clk-si5351 which is a
>> driver for an external programmable clock with N PLLs and M outputs. Now
>> connect a video clock consumer and an audio clock consumer to two
>> different outputs and those to one PLL (as you want audio clock derived
>> from video clock, typical HDMI scenario).
>>
>> Now, there should be a way to tell the generic driver which outputs are
>> allowed to change the PLLs rate and which don't. Otherwise, the clock
>> chip would be pretty useless as e.g. your audio clock consumer will
>> overwrite the rate the video clock consumer has chosen.
> 
> This is really a job for the "coordinated clock rate changes" that are
> currently in development. These specify clock sub-tree snapshots of
> parent and rate configurations that are predefined. These combinations
> can be specified in DT. That helps a lot with clock configurations that
> change per board, or for cases where many combinations of parents and
> dividers can yield the same output rate, but only a subset of those were
> validated by the silicon validation team or had proper timing closure so
> we don't want to rely on the "walk up the tree" algorithm.

Ah! Great to hear there is work on that already. Thanks for the heads
up!

Sebastian
