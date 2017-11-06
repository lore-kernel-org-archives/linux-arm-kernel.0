From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Nov 2017 21:34:27 +0100
Subject: [PATCH] arm64: Make ARMV8_DEPRECATED depend on SYSCTL
In-Reply-To: <1509991631-7938-1-git-send-email-Dave.Martin@arm.com>
References: <1509991631-7938-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAK8P3a19ugqOY3y8Se0BN5S2QriPnf3KTTwbf5vBpBsA6K5FMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 6, 2017 at 7:07 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> If CONFIG_SYSCTL=n and CONFIG_ARMV8_DEPRECATED=y, the deprecated
> instruction emulation code currently leaks some memory at boot
> time, and won't have any runtime control interface.  This does
> not feel like useful or intended behaviour...
>
> This patch adds a dependency on CONFIG_SYSCTL, so that such a
> kernel can't be built in the first place.
>
> It's probably not worth adding the error-handling / cleanup code
> that would be needed to deal with this otherwise: people who
> desperately need the emulation can still enable SYSCTL.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Makes sense here, but I think we might still want to apply the patch
I proposed for other users.

Acked-by: Arnd Bergmann <arnd@arndb.de>
