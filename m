From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Mar 2012 07:03:00 +0200
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <4F74A05E.7050803@wwwdotorg.org>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
 <4F749B58.4070608@wwwdotorg.org>
 <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
 <4F74A05E.7050803@wwwdotorg.org>
Message-ID: <CACRpkda8cYSw6m6GaH403SqoUfn7sky13Gw0okqmZse1ferARA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 7:48 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/29/2012 11:31 AM, viresh kumar wrote:
>> On Mar 29, 2012 10:56 PM, Stephen Warren wrote:
>>> On 03/29/2012 10:34 AM, viresh kumar wrote:
> ...
>>> I vaguely recall raising the same issue before, and Linus saying he
>>> wanted to be consistent with similar list_*() functions in other
>>> subsystems, but personally I'd prefer to evaluate this aspect of the
>>> pinctrl subsystem on its own.
>>
>> Which other subsystems have such stuff?
>
> For example. include/linux/regulator/driver.h struct regulator_ops field
> list_voltage().

Well, actually .list_voltage() returns the voltage per se for each
enumerator, so it works like this quick way to iterate over a list
of integers.

But since we're not really getting anything back from the .list_groups()
callback, just zero or error, there is no specific point in having
it engineered like this.

So please go ahead and patch it in whatever way makes more
sense!

Thanks,
Linus Walleij
