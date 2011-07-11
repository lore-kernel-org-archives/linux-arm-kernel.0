From: khilman@ti.com (Hilman, Kevin)
Date: Mon, 11 Jul 2011 16:38:33 -0700
Subject: [PATCH] OMAP2+: PM: fix watchdog boot when runtime PM is disabled
In-Reply-To: <1310426484-30083-1-git-send-email-khilman@ti.com>
References: <1310426484-30083-1-git-send-email-khilman@ti.com>
Message-ID: <CALyTGOCsfYJifYmrDP=Z3=uN_FhdEkV0Mku70rc_xx8GKOk9-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 4:21 PM, Kevin Hilman <khilman@ti.com> wrote:
> Fix boot crash in watchdog driver when runtime PM is disabled.
>
> When runtime PM is disabled, devices should be left enabled so that
> all device accesses in drivers will succeed even though the runtime PM
> get/put calls are noops.
>
> This is already the case for all devices, but the WDT init has its
> own hwmod postsetup which was not taking this into account.
>
> This fixes a boot crash where the first device access in the WDT probe
> function would crash a booting kernel.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, as this is a boot crash, it should probably be queued for v3.0.
> However, since OMAP2PLUS_TYPICAL always enables runtime PM, this is
> unlikely to be seen unless specifically testing with runtime PM disabled.

I forgot to mention that I added this fix to my for_3.0/pm-fixes-3 branch.

Kevin
