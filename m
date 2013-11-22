From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 22 Nov 2013 21:33:32 +0400
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
 <528B811A.1030501@gmail.com>
 <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
Message-ID: <528F956C.5040107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 12:24 AM, Linus Walleij wrote:
> On Tue, Nov 19, 2013 at 4:17 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> On 11/19/2013 05:00 PM, Linus Walleij wrote:
>
>>> And that happens before the GPIO driver gets registered -> crash.
>>
>> That is not the issue. The real issue is h3xxx using those gpio's without
>> previously calling gpio_request.
>
> Really? But that wasn't done before this patch either.
>
> It is basically OK to use the gpio_* functions before or
> without requesting the GPIOs, it won't look nice but it
> works.
>
>> Unfortunately sa1100 driver doesn't have a
>> good place to request gpios. When faced this problem during locomo
>> refactoring, I ended up with the following piece of code:
> (...)
>> Russell, Linus, what do you think about the previous solution?
>
> That looks OK but is that really the problem?

I have reworked h3xxx GPIO handling to (hopefully) not to cause the 
problem. I have sent the patches yesterday.

Linus, Could you please check if both series work (and make sense to you)?

-- 
With best wishes
Dmitry
