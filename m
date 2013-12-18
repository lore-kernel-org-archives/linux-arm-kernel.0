From: jbaron@akamai.com (Jason Baron)
Date: Wed, 18 Dec 2013 10:55:42 -0500
Subject: [PATCH v6 7/7] jump_label: use defined macros instead of
 hard-coding for better readability
In-Reply-To: <52AD8E10.2010904@gmail.com>
References: <1386691433-6827-1-git-send-email-liuj97@gmail.com>	<1386691433-6827-8-git-send-email-liuj97@gmail.com>
 <20131213112019.751f7946@gandalf.local.home> <52AD8E10.2010904@gmail.com>
Message-ID: <52B1C57E.7000901@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2013 06:10 AM, Jiang Liu wrote:
> On 12/14/2013 12:20 AM, Steven Rostedt wrote:
>> On Wed, 11 Dec 2013 00:03:53 +0800
>> Jiang Liu <liuj97@gmail.com> wrote:
>>
>>> Use macro JUMP_LABEL_TRUE_BRANCH instead of hard-coding for better
>>> readability.
>> Looks good, just a little nit. (see below)
>>
>>> Signed-off-by: Jiang Liu <liuj97@gmail.com>
>>> ---
>>>  include/linux/jump_label.h | 15 ++++++++++-----
> ...
>>> @@ -123,9 +126,11 @@ extern void static_key_slow_dec(struct static_key *key);
>>>  extern void jump_label_apply_nops(struct module *mod);
>>>  
>>>  #define STATIC_KEY_INIT_TRUE ((struct static_key) \
>>> -	{ .enabled = ATOMIC_INIT(1), .entries = (void *)1 })
>>> +	{ .enabled = ATOMIC_INIT(1), \
>>> +	  .entries = (void *)JUMP_LABEL_TYPE_TRUE_BRANCH })
>>>  #define STATIC_KEY_INIT_FALSE ((struct static_key) \
>>> -	{ .enabled = ATOMIC_INIT(0), .entries = (void *)0 })
>>> +	{ .enabled = ATOMIC_INIT(0), \
>>> +	  .entries = (void *)JUMP_LABEL_TYPE_FALSE_BRANCH })
>> Can we prettify the backslashes like:
>>
>> #define STATIC_KEY_INIT_TRUE ((struct static_key)		\
>> 	{ .enabled = ATOMIC_INIT(1),				\
>> 	  .entries = (void *)JUMP_LABEL_TYPE_TRUE_BRANCH })
>> #define STATIC_KEY_INIT_FALSE ((struct static_key)		\
>> 	{ .enabled = ATOMIC_INIT(0),				\
>> 	  .entries = (void *)JUMP_LABEL_TYPE_FALSE_BRANCH })
>>
>>
>> Other than that.
>>
>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> Thanks Steve.
> Will make this change.

Works for me too, feel free to add:

Acked-by: Jason Baron <jbaron@akamai.com>

Thanks,

-Jason
