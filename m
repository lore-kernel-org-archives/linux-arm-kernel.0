From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 18 Apr 2016 15:46:40 -0700
Subject: [PATCH] ARM: davinci_all_defconfig: enable CONFIG_FHANDLE
In-Reply-To: <5710B87A.7060201@ti.com> (Sekhar Nori's message of "Fri, 15 Apr
 2016 15:16:34 +0530")
References: <1460023562-7907-1-git-send-email-nsekhar@ti.com>
 <7h37qvn4v5.fsf@baylibre.com> <570B7C89.9030200@ti.com>
 <5710B87A.7060201@ti.com>
Message-ID: <7hh9eycz73.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> On Monday 11 April 2016 03:59 PM, Sekhar Nori wrote:
>> On Saturday 09 April 2016 03:24 AM, Kevin Hilman wrote:
>>> Sekhar Nori <nsekhar@ti.com> writes:
>>>
>>>> CONFIG_FHANDLE is required by systemd, which is the
>>>> default init system in more and more distributions.
>>>
>>> There's a bunch more options required for basic systemd support also[1],
>>> so those should probably be added with the changelog referencing the
>>> source[1]
>> 
>> Good point. Will send a v2.
>
> I looked at this bit more closely. CONFIG_EPOLL, CONFIG_SIGNALFD, and
> CONFIG_TIMERFD are all default y and so actually get removed when the
> next 'make savedefconfig' syncup will be done. Same thing for PROC_FS
> and SYSFS.
>
> Looking at the list of required options, FHANDLE is the only one which
> needs to get enabled explicitly. Also, CONFIG_INOTIFY is actually a
> stale entry that can be removed.
>
> Based on this, I think the updated patch can be:
>
> ---8<---
> From: Sekhar Nori <nsekhar@ti.com>
> Date: Fri, 15 Apr 2016 14:19:26 +0530
> Subject: [PATCH] ARM: davinci_all_defconfig: support systemd
>
> CONFIG_FHANDLE is required by systemd[1], which is the
> default init system in more and more distributions.
> So lets enable it for DaVinci platforms as well.
>
> While at it, remove stale entry CONFIG_INOTIFY=y
>
> [1] https://github.com/systemd/systemd/blob/master/README#L37
>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
