From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Dec 2011 23:06:47 -0800
Subject: [GIT PULL] at91: devices and boards files update for 3.3
In-Reply-To: <4EEA034C.9020800@atmel.com>
References: <4EEA034C.9020800@atmel.com>
Message-ID: <CAOesGMiEg-8LA9-yUXRrDwGLGfVeFn7Xax9jhkDr+fZ5GU06QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 15, 2011 at 6:25 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof,
>
> This pull request adds the ISI to the sam9m10g45 board. As ISI has
> been waited for a long time on AT91, I think it is not possible to wait
> for the DT support. Moreover, DT support for this camera sensor + ISI
> soc interface seems not so trivial and will certainly need a handful of
> kernel releases before being stabilized.
> Other changes are quite simple and self-explanatory...
>
> The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:
>
> ?Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)
>
> are available in the git repository at:
> ?git://github.com/at91linux/linux-at91.git for-arnd-3.3-device_board

Sure, since you removed a defconfig I'm OK with a small amount of
board addition for ISI.

However, I noticed that it doesn't build with at91sam9g45_defconfig:

arch/arm/mach-at91/board-sam9m10g45ek.c:195: error: unknown field
'full_mode' specified in initializer
arch/arm/mach-at91/board-sam9m10g45ek.c:195: warning: excess elements
in struct initializer
arch/arm/mach-at91/board-sam9m10g45ek.c:195: warning: (near
initialization for 'isi_data')
arch/arm/mach-at91/board-sam9m10g45ek.c:198: error: unknown field
'mck_hz' specified in initializer


Please fixup and send fresh request.

-Olof
