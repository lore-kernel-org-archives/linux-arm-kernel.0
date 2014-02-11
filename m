From: carlo@caione.org (Carlo Caione)
Date: Tue, 11 Feb 2014 07:58:01 +0100
Subject: [linux-sunxi] Re: [PATCH 1/3] mfd: axp20x: Add mfd driver for
 axp20x PMIC
In-Reply-To: <CAOQ7t2axObbBpVcF0z826Q2b0DaCx+wr0fvJ1X9Ek33174pOwA@mail.gmail.com>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-2-git-send-email-carlo@caione.org>
 <20140210211900.GC32042@lee--X1>
 <CAOQ7t2axObbBpVcF0z826Q2b0DaCx+wr0fvJ1X9Ek33174pOwA@mail.gmail.com>
Message-ID: <CAOQ7t2aMa7TkKTMc8zo9a1KYwe+PrPt+wrFaEis6SqnLRahpNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:34 PM, Carlo Caione <carlo@caione.org> wrote:

>>> +static struct axp20x_dev *axp20x_pm_power_off;
>>
>> This looks pretty unconventional. What's the point of it?
>
> On a single board we can have multiple AXPs so I track which one is in
> charge of powering off the board (and to get the correct device in the
> axp20x_power_off())

<snip>

>>> +
>>> +     if (!pm_power_off) {
>>> +             axp20x_pm_power_off = axp20x;
>>> +             pm_power_off = axp20x_power_off;
>>> +     }
>>
>> Can you describe to me what you're using the pm_power_off call-back
>> for please?
>
> It's meant to poweroff the board

Actually what is missing here is also a way to determine which device
is in charge of powering off when multiple AXPs are registered.
I'll fix it in v2.

Thanks,

-- 
Carlo Caione
