From: carlo@caione.org (Carlo Caione)
Date: Mon, 10 Feb 2014 21:25:30 +0100
Subject: [linux-sunxi] Re: [PATCH 1/3] mfd: axp20x: Add mfd driver for
 axp20x PMIC
In-Reply-To: <20140210200232.GB3192@lukather>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-2-git-send-email-carlo@caione.org>
 <20140210200232.GB3192@lukather>
Message-ID: <CAOQ7t2YYyFdVoEwsHgvd1nC4N3ZHjhtt6ZfUbuzfb0FbNCgsnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 9:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
>> +static struct resource axp20x_pek_resources[] = {
>> +     {
>> +             .name   = "PEK_DBR",
>> +             .start  = AXP20X_IRQ_PEK_RIS_EDGE,
>> +             .end    = AXP20X_IRQ_PEK_RIS_EDGE,
>> +             .flags  = IORESOURCE_IRQ,
>> +     },
>> +     {
>> +             .name   = "PEK_DBF",
>> +             .start  = AXP20X_IRQ_PEK_FAL_EDGE,
>> +             .end    = AXP20X_IRQ_PEK_FAL_EDGE,
>> +             .flags  = IORESOURCE_IRQ,
>> +     },
>> +
>> +};
>
> From your documentation, it seems like you want to declare them in the
> DT too. Why do you need to declare the resources in both locations?

It's not really a need, I thought it was a bit "clearer" also to have
them in DT.
But I agree it is redundant. I'll fix in v2.

Thank you,

-- 
Carlo Caione
