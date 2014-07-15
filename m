From: james.l.morris@oracle.com (James Morris)
Date: Tue, 15 Jul 2014 11:53:10 +1000
Subject: [PATCH v10 0/11] seccomp: add thread sync ability
In-Reply-To: <CAGXu5jJJsiTxxn5UijkBz7jpWgqg01BS=Zc0WbHXbs0vH_xPMQ@mail.gmail.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>	<20140711164931.GA18473@redhat.com>	<CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
 <CAGXu5jJJsiTxxn5UijkBz7jpWgqg01BS=Zc0WbHXbs0vH_xPMQ@mail.gmail.com>
Message-ID: <53C48986.5010109@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 04:59 AM, Kees Cook wrote:
> Hi James,
>
> Is this series something you would carry in the security-next tree?
> That has traditionally been where seccomp features have landed in the
> past.
>
> -Kees
>
>
> On Fri, Jul 11, 2014 at 10:55 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Jul 11, 2014 at 9:49 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 07/10, Kees Cook wrote:
>>>>
>>>> This adds the ability for threads to request seccomp filter
>>>> synchronization across their thread group (at filter attach time).
>>>> For example, for Chrome to make sure graphic driver threads are fully
>>>> confined after seccomp filters have been attached.
>>>>
>>>> To support this, locking on seccomp changes via thread-group-shared
>>>> sighand lock is introduced, along with refactoring of no_new_privs. Races
>>>> with thread creation are handled via delayed duplication of the seccomp
>>>> task struct field and cred_guard_mutex.
>>>>
>>>> This includes a new syscall (instead of adding a new prctl option),
>>>> as suggested by Andy Lutomirski and Michael Kerrisk.
>>>
>>> I do not not see any problems in this version,
>>
>> Awesome! Thank you for all the reviews. :) If Andy and Michael are
>> happy with this too, I think this is in good shape. \o/
>>
>> -Kees
>>
>>>
>>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>>
>>
>>
>>
>> --
>> Kees Cook
>> Chrome OS Security
>
>
>

Yep, certainly.
