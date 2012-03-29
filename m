From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 Mar 2012 11:26:48 -0600
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
Message-ID: <4F749B58.4070608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2012 10:34 AM, viresh kumar wrote:
> Most of the SoC drivers implement list_*() routines for pinctrl, pinmux,
> pinconf, etc, And these routines continue returning zero until the second
> argument is greater than total count of available groups, function, etc.
> 
> I will take struct pinctrl_ops as an example to elaborate my concern/doubts.
> 
> There are few concerns here:
> - list_groups() is called multiple times. If the purpose of this routine is to
>   only check the number of groups available, then why not remove it and create
>   another routine which returns number of total groups. Over which, we can run a
>   simple loop.
> - All client drivers have checks in their ops routines to check the range of
>   groups, which is just not required if we pass the correct number to pinctrl
>   framework. Because these ops are going to be called via pinctrl, and we can
>   trust on it and place these range checkers there only to make SoC drivers
>   simple.
> 
> I just wanted to have different views about my concerns/idea before i start
> coding. If this idea looks fine, i would do this change across pinmux framework.

The concept is fine by me.

I vaguely recall raising the same issue before, and Linus saying he
wanted to be consistent with similar list_*() functions in other
subsystems, but personally I'd prefer to evaluate this aspect of the
pinctrl subsystem on its own.
