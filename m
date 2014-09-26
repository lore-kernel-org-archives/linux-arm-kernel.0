From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 26 Sep 2014 06:58:10 -0700
Subject: [PATCH v2 1/2] watchdog: sunxi: support parameterized compatible
 strings
In-Reply-To: <CAGb2v66dv4TRKB3LDksTudYPQThOV9NaEZDByZVSqedDOjekwQ@mail.gmail.com>
References: <1411315519-26257-1-git-send-email-wens@csie.org>
 <1411315519-26257-2-git-send-email-wens@csie.org>
 <541EFD9A.2000406@roeck-us.net>
 <CAGb2v66dv4TRKB3LDksTudYPQThOV9NaEZDByZVSqedDOjekwQ@mail.gmail.com>
Message-ID: <542570F2.4090908@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2014 01:29 AM, Chen-Yu Tsai wrote:
> On Mon, Sep 22, 2014 at 12:32 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 09/21/2014 09:05 AM, Chen-Yu Tsai wrote:
>>>
>>> This patch adds support for hardware parameters tied to compatible
>>> strings, so similar hardware can reuse the driver.
>>>
>>> This will be used to support the newer watchdog found in A31 and
>>> later SoCs. Differences in the new hardware include separate
>>> interrupt lines for each watchdog, and corresponding interrupt
>>> control/status registers. Watchdog control registers were also
>>> slightly rearranged.
>>>
>>> Also replace ioread32()/iowrite32() with readl()/writel() in various
>>> places changed.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>
> Hi Guenter,
>
> Are you submitting the restart handler patches for inclusion in 3.18?

Yes, should go in through Andrew's tree or through one of the branches
depending on it.

> If so, are you taking any related patches or patches depending on
> that series?
>
In general no, but I just sent a pull request pointing to an immutable branch
containing the series. Affected maintainers should merge this branch into
the affected subject branch(es).

I do have a number of related patches in my watchdog-next branch. I'll send
an updated pull request with those to Wim later today.

Thanks,
Guenter
