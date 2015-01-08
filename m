From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 08 Jan 2015 11:29:40 -0600
Subject: Linux 3.19-rc3
In-Reply-To: <20150108134520.GC14200@e104818-lin.cambridge.arm.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com>
 <20150108134520.GC14200@e104818-lin.cambridge.arm.com>
Message-ID: <54AEBE84.6090307@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2015 07:45 AM, Catalin Marinas wrote:
> On Thu, Jan 08, 2015 at 12:51:31PM +0000, Mark Langsdorf wrote:
>> On 01/05/2015 07:46 PM, Linus Torvalds wrote:
>>> It's a day delayed - not because of any particular development issues,
>>> but simply because I was tiling a bathroom yesterday. But rc3 is out
>>> there now, and things have stayed reasonably calm. I really hope that
>>> implies that 3.19 is looking good, but it's equally likely that it's
>>> just that people are still recovering from the holiday season.
>>
>> I'm consistently getting an out of memory killer triggered when
>> compiling the kernel (make -j 16 -s) on a 16 core ARM64 system
>> with 16 GB of memory. This doesn't happen when running a 3.18
>> kernel.
>>
>> I'm going to start bisecting the failure now, but here's the crash
>> log in case someone can see something obvious in it.

> Can you disable (transparent) huge pages? I don't have any better at the
> moment suggestion apart from bisecting.

I didn't have transparent huge pages on. Turning off hugetblfs didn't
change anything. Turning off 64K pages isn't an option because of
firmware constraints.

--Mark Langsdorf
