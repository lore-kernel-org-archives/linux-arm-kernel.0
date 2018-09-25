From: joelaf@google.com (Joel Fernandes)
Date: Tue, 25 Sep 2018 13:37:14 -0700
Subject: [PATCH 2/6] pstore: Add event tracing support
In-Reply-To: <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
 <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
Message-ID: <CAJWu+ooTi+9Hp6xWpje-zoFOdRpZPLMvTzTDEk8Vf-y4TicvUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2018 at 8:33 AM, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
> On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
>>
>> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>>>
>>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>>
>>>>
>>>> +
>>>> +       trace_seq_init(&iter->seq);
>>>> +       iter->ent = fbuffer->entry;
>>>> +       event_call->event.funcs->trace(iter, 0, event);
>>>> +       trace_seq_putc(&iter->seq, 0);
>>>
>>>
>>> Would it be possible to store the binary trace record in the pstore
>>> buffer instead of outputting text? I suspect that will both be faster
>>> and less space.
>>>
>>
>> I will try this and come back.
>>
>
> Hi Joel,
>
> I removed trace_seq_putc and there is some improvement seen: 203 MB/s
>
> # dd if=/dev/zero of=/dev/null status=progress
> 12207371264 bytes (12 GB, 11 GiB) copied, 60 s, 203 MB/s^C
> 24171926+0 records in
> 24171926+0 records out
> 12376026112 bytes (12 GB, 12 GiB) copied, 60.8282 s, 203 MB/s
>
> This seems good when compared to 190 MB/s seen previously.
> If this is Ok, then I will spin v2 with changes suggested.

Sorry for slow reply, yes that sounds good and a worthwhile perf improvement.

thanks,

 - Joel
