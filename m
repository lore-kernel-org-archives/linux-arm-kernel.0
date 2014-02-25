From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Feb 2014 20:10:54 +0530
Subject: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
In-Reply-To: <15001517.xLHO8lGdWr@vostro.rjw.lan>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
 <530BAA31.4050701@codeaurora.org>
 <CAKohpo=0CgzjCgKnDxUMcN6-CgbQ2ML=Tx-K8fS7=VJJYOD0eg@mail.gmail.com>
 <15001517.xLHO8lGdWr@vostro.rjw.lan>
Message-ID: <CAKohponkjccKjc9xBQ3kCjdTMqFtKLCh1-mQXMS579+2_JmTCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2014 18:34, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Well, that depends on what the current users expect it to look like initially.
> It should be initialized to the point in which all of them can handle it
> correctly.

Exactly.

> That's not going to work in at least some cases anyway, because for some types
> of HW we simply can't retrieve the current frequency in a non-racy way.

I agree. But this is all that we can guarantee here :)
