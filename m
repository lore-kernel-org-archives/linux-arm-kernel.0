From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 17 Dec 2014 15:25:09 -0800
Subject: [PATCH] ARM: brcmstb: update CPU power management sequence
In-Reply-To: <1418786030-23455-1-git-send-email-computersforpeace@gmail.com>
References: <1418786030-23455-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <CADtm3G5ZaOsJ_pvY2ho0yYhbhbqtCwsPZfnEc0rwhCBC1ho16g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 7:13 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> The automatic CPU power state machine for B15 CPUs does not work
> reliably as-is. This patch implements a manual sequence in software to
> replace it.
>
> This was tested successfully with over 10,000 hotplug cycles of
> something like this:
>
>   echo 0 > /sys/devices/system/cpu/cpu1/online
>   echo 1 > /sys/devices/system/cpu/cpu1/online
>
> whereas the existing sequence often locks up after a few hundred cycles.
>
> Fixes: 62639c2f5332 ("ARM: brcmstb: reintroduce SMP support")
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
