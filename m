From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 28 Aug 2013 12:32:54 -0600
Subject: [PATCH RFC v2 3/5] spmi: add generic SPMI controller binding
 documentation
In-Reply-To: <20130828180025.GA808@joshc.qualcomm.com>
References: <cover.1377202730.git.joshc@codeaurora.org>
 <e42576b69ef3d4e624fbfa2f32f6f79a931b55d6.1377202730.git.joshc@codeaurora.org>
 <5217DB0C.7000101@wwwdotorg.org> <20130827170120.GR4035@joshc.qualcomm.com>
 <521D2047.8030300@wwwdotorg.org> <20130828180025.GA808@joshc.qualcomm.com>
Message-ID: <521E4256.4070805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2013 12:00 PM, Josh Cartwright wrote:
> On Tue, Aug 27, 2013 at 03:55:19PM -0600, Stephen Warren wrote:
>> On 08/27/2013 11:01 AM, Josh Cartwright wrote:
>> ...
>>> If we want to ensure for the generic bindings that we are fulling
>>> characterizing/describing the SPMI bus, then we'll additionally need to
>>> tackle an additional identified assumption:
>>>
>>>   4. One master per SPMI bus.  (The SPMI spec allows for up to 4
>>>      masters)
>>>
>>> On the Snapdragon 800 series, there exists only one software-controlled
>>> master, but it is conceivably possible to have a setup with two
>>> software-controlled masters on the same SPMI bus.
>>>
>>> This necessarily means that the description of the slaves and the
>>> masters will need to be decoupled; I'm imagining a generic binding
>>> supporting multiple masters would look something like this:
>>
>> Is there a need to represent the other masters in the DT? Sure they're
>> there in HW, but if there's no specific way for the
>> CPU-to-which-the-DT-applies to actually interact with those other
>> masters (except perhaps by experiencing some arbitration delays) then
>> presumably there's no need to represent the other masters in DT?
> 
> My example is contrived, but there is nothing in the SPMI spec
> preventing two masters from being controllable by the same
> CPU-to-which-the-DT-applies, sharing the same underlying bus.

That's true.

> I would also expect this configuration to be uncommon, I'm checking with
> some folks with more SPMI experience to make sure they agree.
> 
> Interestingly, i2c as far as I can tell has also made the same
> assumption.  There doesn't appear to be any way to express a
> multi-master i2c setup where both masters are controlled by the same OS.

Yes, I think it's a fair assumption that we don't need to represent
that; I immediately thought about the I2C counter-example after reading
your first paragraph.
