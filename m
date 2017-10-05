From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Thu, 5 Oct 2017 12:52:41 +0300
Subject: [PATCH v3][for 4.14] xhci: allow TRACE to work with EVENT ring
 dequeue
In-Reply-To: <3100d137-d581-665f-9665-561578a61ac8@codeaurora.org>
References: <1506342365-11268-1-git-send-email-awallis@codeaurora.org>
 <063D6719AE5E284EB5DD2968C1650D6DD007F5A1@AcuExch.aculab.com>
 <59C9F74F.2030306@linux.intel.com>
 <3100d137-d581-665f-9665-561578a61ac8@codeaurora.org>
Message-ID: <59D600E9.7010105@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.10.2017 19:07, Adam Wallis wrote:
> On 9/26/2017 2:44 AM, Mathias Nyman wrote:
>> On 25.09.2017 19:09, David Laight wrote:
>>> From: Adam Wallis
>>>> Sent: 25 September 2017 13:26
>>>> inc_deq() currently bails earlier for EVENT rings than the common return
>>>> point of the function, due to the fact that EVENT rings do not have
>>>> link TRBs. The unfortunate side effect of this is that the very useful
>>>> trace_xhci_inc_deq() function is not called/usable for EVENT ring
>>>> debug.
>>>
>>> Is it actually worth using different functions for the different
>>> ring types?
>>>   From what I remember there are conditionals in a lot of the functions
>>> but they are fixed for most of the call sites.
>>>
>>
>> There's some restructuring and refactoring that could be done in xhci,
>> but that's not part of this patch.
>>
>> This will just enable better debugging.
>>
>> Applying this patch
> Sounds great, thanks! Will this be going in on 4.14 sometime shortly? I hadn't
> seen it in your tree and was curious since we are tracking internally. Thanks!
>

Now pushed to my for-usb-next branch and sent forward to Greg.
On its way to 4.15

-Mathias
