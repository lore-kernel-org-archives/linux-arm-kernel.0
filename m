From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 31 Mar 2011 09:54:23 +0100
Subject: How to handle kprobe bugs?
In-Reply-To: <1301510088.2488.184.camel@computer2.home>
References: <1301493213.2488.41.camel@computer2.home>
	<20110330141011.GA2844@arm.com>
	<1301510088.2488.184.camel@computer2.home>
Message-ID: <AANLkTimdUnzSaUWsF4T0vFOt7-iWy5tVSW_K2DoqyOAz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 7:34 PM, Tixy <tixy@yxit.co.uk> wrote:
> On Wed, 2011-03-30 at 15:10 +0100, Dave Martin wrote:
>> On Wed, Mar 30, 2011 at 02:53:33PM +0100, Tixy wrote:
>> > I also find that instruction emulation for some (all?) ARMv6K and newer
>> > instructions are missing. E.g. hint instructions like NOP and WFI. Shall
>> > I produce a second patch to add these?
>>
>> Sure.
>>
>> Note that you should emulate all the hinted NOPs as actual NOPs,
>> since the event the hint waits for may happen in the meantime;
>> under some circumstances that would lead to stalls.
>
> Good point :-) Conversely, things like Send Event shouldn't be actual
> NOPs.

Also a good point!  For this one, I guess you'll need to take into
account what platform you're acutally running on, also.

Cheers
---Dave
