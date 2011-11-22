From: rabin@rab.in (Rabin Vincent)
Date: Tue, 22 Nov 2011 23:33:23 +0530
Subject: [PATCH 3/4] ARM: extract out code patch function from kprobes
In-Reply-To: <1321951733.2557.35.camel@computer2>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-3-git-send-email-rabin@rab.in>
 <1321951733.2557.35.camel@computer2>
Message-ID: <CAH+eYFDgTqxSJVrp=cYbDA_Kvc237WOBt1qVUYY3XUEKTpUnkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 14:18, Tixy <tixy@yxit.co.uk> wrote:
> On Mon, 2011-11-21 at 20:43 +0530, Rabin Vincent wrote:
>> Extract out the code patching code from kprobes so that it can be used
>> from the jump label code. ?Additionally, the separated code:
>>
>> ?- Uses the IS_ENABLED() macros instead of the #ifdefs for THUMB2
>> ? ?support
>>
>> ?- Unifies the two separate functions in kprobes, providing one function
>> ? ?that uses stop_machine() internally, and one that can be called from
>> ? ?stop_machine() directly
>>
>> ?- Patches the text on all CPUs only on processors requiring software
>> ? ?broadcasting of cache operations
>>
>> Cc: Jon Medhurst <tixy@yxit.co.uk>
>> Signed-off-by: Rabin Vincent <rabin@rab.in>
>> ---
>
> Looks good. I've a couple of minor inline comments below.

Thank you for the review.  I'll address all your comments in v2.
