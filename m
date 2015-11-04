From: dcashman@android.com (Daniel Cashman)
Date: Wed, 4 Nov 2015 11:36:07 -0800
Subject: [PATCH v2 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <877flxo9j5.fsf@x220.int.ebiederm.org>
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <20151104093957.GA31378@dhcp22.suse.cz>
 <877flxo9j5.fsf@x220.int.ebiederm.org>
Message-ID: <563A5E27.2060607@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/4/15 11:21 AM, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
>> On Tue 03-11-15 10:10:03, Daniel Cashman wrote:
>> [...]
>>> +This value can be changed after boot using the
>>> +/proc/sys/kernel/mmap_rnd_bits tunable
>>
>> Why is this not sitting in /proc/sys/vm/ where we already have
>> mmap_min_addr. These two sound like they should sit together, no?
> 
> Ugh.  Yes.  Moving that file before it becomes part of the ABI sounds
> like a good idea.  Daniel when you get around to v3 please move the
> file.

To answer the first question: it was put there because that's where
randomize_va_space is located, which seemed to me to be the
most-related/similar option.  That being said, moving it under vm works
too.  Will change for patch-set 3.

Thank You,
Dan
