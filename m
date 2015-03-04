From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 04 Mar 2015 16:27:29 +0000
Subject: [PATCH v2 6/6] target-arm: cpu.h document why env->spsr exists
In-Reply-To: <CAFEAcA9x_6jGfNTpMLYYbmEp19U7sOVjcgzCggwkwZiyCM5yug@mail.gmail.com>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
 <1425479753-18349-7-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA9x_6jGfNTpMLYYbmEp19U7sOVjcgzCggwkwZiyCM5yug@mail.gmail.com>
Message-ID: <87vbig683y.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 4 March 2015 at 23:35, Alex Benn?e <alex.bennee@linaro.org> wrote:
>> I was getting very confused about the duplication of state. Perhaps we
>> should just get rid of env->spsr and use helpers that understand the
>> banking?
>
> Doesn't seem worth changing the current working code to something
> else that's strictly less efficient... spsr is by no means the
> only banked-by-mode register, and it works just like all the others.

Fair enough. I just wanted to make it clear it was a cached value for
the benefit of TCG.

>
> -- PMM

-- 
Alex Benn?e
