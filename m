From: keescook@chromium.org (Kees Cook)
Date: Mon, 14 Jul 2014 13:34:36 -0700
Subject: [PATCH v10 0/11] seccomp: add thread sync ability
In-Reply-To: <CALCETrVXgA9a2f7VwnCYW4_XB+JAPRSR8xsuH_ZYbA82=ZozRw@mail.gmail.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
 <20140711164931.GA18473@redhat.com>
 <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
 <CALCETrVXgA9a2f7VwnCYW4_XB+JAPRSR8xsuH_ZYbA82=ZozRw@mail.gmail.com>
Message-ID: <CAGXu5j+A0GodNCnjqpYQXC2HL+S08_yP5H_n_v51VpE4UnnK7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 12:04 PM, Andy Lutomirski <luto@amacapital.net> wrote:
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
>
> I think I'm happy with it.  Is it in git somewhere for easy perusal?
> I have a cold, so my reviewing ability is a bit off, but I want to
> take a look at the final version, and git is a little easier than
> email for this.

Yes, absolutely:
https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp-tsync

Thanks for looking it over, and I hope you feel better soon!

-Kees

-- 
Kees Cook
Chrome OS Security
