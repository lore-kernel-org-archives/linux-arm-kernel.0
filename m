From: ccross@android.com (Colin Cross)
Date: Sun, 10 Jul 2011 15:14:33 -0700
Subject: [PATCH 0/6 V2] ARM: tegra: paz00 patches for 2.6.40
In-Reply-To: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
References: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
Message-ID: <CAMbhsRSH2iyv0_1seVtwSQ7AbHmPbz+VqSVkhfLgsNA8+dOwJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 5:08 AM, Marc Dietrich <marvin24@gmx.de> wrote:
> Hi Collin, Olof,
>
> the following patches are intended for 2.6.40 merge. They are mostly similar
> to the TrimSlice patches sent by Mike a few days ago.
>
> We are still stuggling with the sound codec (alc5632) and the nvec, so there
> is nothing to connect to the i2c yet. On the other hand, I'm wondering what's
> up with the atd7461 included in most (all?) boards. It's compatible with lm90,
> but the driver will never register because of the wrong name.
>
> May I ask if there is some timeline for framebuffer integration? A netbook
> without display is of not much use (ok, same holds for keyboard/mouse).
>
> Thanks!
>
> Marc
>
> Changes in V2:
> ? ?- add some more blurb to the commit messages
> ? ?- change the machine to some neater name (patch 5)
> ? ?- enable the wifi board during boot (patch 6)
>
>
> Marc Dietrich (6):
> ?ARM: tegra: paz00: whitespace cleanup
> ?ARM: tegra: paz00: register i2c busses
> ?ARM: tegra: paz00: enable usb ports
> ?ARM: tegra: paz00: cleanup sdhci ports
> ?ARM: tegra: paz00: change the machine name
> ?ARM: tegra: paz00: enable wifi card
>
> ?arch/arm/mach-tegra/board-paz00-pinmux.c | ? 12 ++--
> ?arch/arm/mach-tegra/board-paz00.c ? ? ? ?| ? 96 ++++++++++++++++++++++++++----
> ?arch/arm/mach-tegra/board-paz00.h ? ? ? ?| ? 17 ++++--
> ?3 files changed, 102 insertions(+), 23 deletions(-)
>
> --
> 1.7.4.2
>
>

I pushed this series to for-next, except for patch 6 "ARM: tegra:
paz00: enable wifi card".

I have some cleanup patches that go on top to reduce some of the
duplicate platform data added by trimslice and paz00, I'd appreciate a
tested-by once I post those.
