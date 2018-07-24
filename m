From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2018 15:48:39 +0200
Subject: [PATCH] arm: enable RapidIO config options in Kconfig
In-Reply-To: <20180724134122.86718-1-acolin@isi.edu>
References: <20180724134122.86718-1-acolin@isi.edu>
Message-ID: <CAK8P3a1sA5tw1oZ+vM_BgR3jU2ww0g6_QDn6sxF2SC4PtrP0Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 3:41 PM, Alexei Colin <acolin@isi.edu> wrote:
> ARM SoCs with a PCI bus offer the RapiodIO config menu; SoCs with
> RapidIO IP blocks but without a PCI bus, need to add "select
> HAS_RAPIDIO" to the Kconfig entry for that SoC (e.g. ARCH_*).
>
> HAS_RAPIDIO was chosen over HAVE_RAPIDIO to be consistent with
> other architectures which already define this flag (powerpc).
>
> Signed-off-by: Alexei Colin <acolin@isi.edu>
> ---
>
> Tested that kernel builds with RapidIO subsystem and switch drivers enabled.
> Maintainers for RapidIO subsystem CCed.
> Sending a similar patch to ARM64 maintainers shortly.


Could you move CONFIG_RAPIDIO to drivers/rapidio? That
would avoid repeating it for each of the five architectures, and
make it more consistent with other subsystems.

       Arnd
