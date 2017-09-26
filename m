From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 26 Sep 2017 09:44:31 +0300
Subject: [PATCH v3][for 4.14] xhci: allow TRACE to work with EVENT ring
 dequeue
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD007F5A1@AcuExch.aculab.com>
References: <1506342365-11268-1-git-send-email-awallis@codeaurora.org>
 <063D6719AE5E284EB5DD2968C1650D6DD007F5A1@AcuExch.aculab.com>
Message-ID: <59C9F74F.2030306@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.09.2017 19:09, David Laight wrote:
> From: Adam Wallis
>> Sent: 25 September 2017 13:26
>> inc_deq() currently bails earlier for EVENT rings than the common return
>> point of the function, due to the fact that EVENT rings do not have
>> link TRBs. The unfortunate side effect of this is that the very useful
>> trace_xhci_inc_deq() function is not called/usable for EVENT ring
>> debug.
>
> Is it actually worth using different functions for the different
> ring types?
>  From what I remember there are conditionals in a lot of the functions
> but they are fixed for most of the call sites.
>

There's some restructuring and refactoring that could be done in xhci,
but that's not part of this patch.

This will just enable better debugging.

Applying this patch

Thanks
-Mathias
