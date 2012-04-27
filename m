From: olof@lixom.net (Olof Johansson)
Date: Fri, 27 Apr 2012 14:39:35 -0700
Subject: Tegra board file deprecation schedule
In-Reply-To: <4F9B0E7C.1060408@wwwdotorg.org>
References: <4F9B0E7C.1060408@wwwdotorg.org>
Message-ID: <CAOesGMh3NY4cQERSQY-p0QsMtcCXyhkdGSGnnrckcz8-DPjbBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 2:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Eventually, Tegra support will become device tree only in the mainline
> kernel; arch/arm/mach-tegra/board* will be deleted.
>
> I propose the following policy towards this goal: I'd like to maintain
> the board files until the relevant device tree file has the same level
> of functionality. Once that is achieved, and a Linus kernel is release
> with full support for the board via device tree, the board files can be
> deleted from the next kernel release.
>
> Does anyone have any issues with this?

Sounds great, but I think you can be more aggressive than this; no
need to keep the non-DT board alive for the final release.

> The device tree conversion status is:
>
> Cardhu/Ventana:
>
> None; already device tree only
>
> Seaboard:
>
> Kaen and Wario board variants are not explicitly supported via device
> tree. However, the differences are almost entirely minor (at least as
> far as the current features supported in board-seaboard*), so anyone
> wishing to use those board variants could easily create their own device
> tree files. I plan to ignore Kaen/Wario and delete board-seaboard* in
> 3.6 unless someone objects.

Wario is no longer an active platform and can be completely removed;
I'll post patches for this.

Kaen is somewhat active, but I can send a device tree for it;
definitely ok to sunset before it's in since we can carry it locally
in our downstream kernel tree if needed.

>
> Harmony:
>
> Missing support for TPS6586x regulator, and PCI-Express controller.
> Thierry is working on this. I hope this support will be ready to be
> merged for 3.6, and hence board-harmony* can be deleted in 3.7.
>
> TrimSlice:
>
> Missing RTC and Micro-SD slot support. I've sent patches for this, which
> will be merged today.
>
> Missing audio support. I sent patches for this today. I hope they'll be
> merged for 3.5.
>
> Missing PCI-Express support; status above.
>
> I hope board-trimslice* can be deleted in 3.7.
>
> Paz00/Toshiba AC100:
>
> Missing rfkill button support. Defining a good binding for this might
> prove challenging. Marc Dietrich started work on this a while back. I
> pinged him to see if he intends to continue this work.
>
> This is probably the long-pole for completely removing board files,
> unless we ignore the rfkill feature and delete the board files anyway.

if this is the only thing holding it up sunsetting all non-DT boards
on tegra then I suggest just adding a one-time runtime test that adds
a platform device on that device tree platform. As long as there
aren't more of them creeping in over time that should be OK.



-Olof
