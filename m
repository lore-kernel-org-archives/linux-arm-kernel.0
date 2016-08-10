From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 10 Aug 2016 14:04:58 -0500
Subject: [PATCH] ARM: VDSO: put read only/mostly objects into proper
 sections
In-Reply-To: <CAGXu5jJCjk-3nBcMamJhpK7m+qfcdu6mvD6heYR=gJkAO40Jxg@mail.gmail.com>
References: <1470820187-1032-1-git-send-email-jszhang@marvell.com>
 <20160810175958.4dcfc5e3@xhacker>
 <CAGXu5jJCjk-3nBcMamJhpK7m+qfcdu6mvD6heYR=gJkAO40Jxg@mail.gmail.com>
Message-ID: <63c1b715-5e71-b503-d1fc-e5622e53b815@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 01:47 PM, Kees Cook wrote:
> On Wed, Aug 10, 2016 at 2:59 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
>> + Kees
>>
>> On Wed, 10 Aug 2016 17:09:47 +0800 wrote:
>>
>>> vdso_data_mapping is never modified, so mark it as const.
>>>
>>> vdso_data_page and vdso_text_mapping are initialized by vdso_init(),
>>> thereafter are mostly read during vdso special mapping handling.
>>>
>>> The fact that they are mostly read and not written to makes them
>>> candidates for __read_mostly declarations.
>>
>> Inspired by Kees's "arm: apply more __ro_after_init", is it better
>> to mark these vars as __ro_after_init?
> 
> Yeah, if they're not written outside of __init, please do. It would be
> a nice complement to commit 11bf9b865898 ("ARM/vdso: Mark the vDSO
> code read-only after init").

I agree.
