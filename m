From: james.morse@arm.com (James Morse)
Date: Tue, 1 May 2018 13:50:43 +0100
Subject: [PATCH v3 01/12] ACPI / APEI: Move the estatus queue code up, and
 under its own ifdef
In-Reply-To: <877eonr708.fsf@e105922-lin.cambridge.arm.com>
References: <20180427153510.5799-1-james.morse@arm.com>
 <20180427153510.5799-2-james.morse@arm.com>
 <877eonr708.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <4d3b63b0-66ad-8903-ea9a-6fa590a017d5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

On 01/05/18 11:43, Punit Agrawal wrote:
> James Morse <james.morse@arm.com> writes:
>> Notes for cover letter:
>> ghes.c has three things all called 'estatus'. One is a pool of memory
>> that has a static size, and is grown/shrunk when new NMI users are
>> allocated.
>> The second is the cache, this holds recent notifications so we can
>> suppress notifications we've already handled.
>> The last is the queue, which hold data from NMI notifications (in pool
>> memory) that can't be handled immediatly.
> 
> 
> I am guessing you intended to drop the notes before sending the patch
> out.

Ha, oops!

> Calling this out as it'd make sense to clean-this up if the series is
> ready for merging.

Yes, thanks for calling that out.

I've deleted them now (copy-paste cover-letter serves the same purpose), so any
v4 will drop this.


Thanks,

James
