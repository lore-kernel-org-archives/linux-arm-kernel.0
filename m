From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Apr 2018 22:50:58 +0200
Subject: [RFC 00/10] ARM: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Message-ID: <CAK8P3a2CZU1CYFt0fdVSFFnj2Wg=mUcC=yuWAW7zDO0u2Q2dUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:32 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
>
> Overview
> ========
> Let's continue the removal of old platforms. We already get rid of Exynos4212.
> Now it's time for Exynos5440.
>
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
>
> The only development happening around it is the PCIe driver for Exynos5433
> (ARMv8). [1]
>
> Removing Exynos5440, makes our life slightly easier:
> 1. Less maintenance,
> 2. Smaller code, less quirks,
> 3. No need to preserve (imaginary) backward-compatibility for Exynos PCIe
>    driver (so it is easier to add support for Exynos5433).
>
>
> Because of point (3) above - I left the PCIe and PCIe PHY drivers intact.
>
>
> Dependencies
> ============
> I think about starting with removal of DTS in some kernel release (patch 1/10).
> Then all drivers can be removed/updated - subsystem maintainers can pick their
> patches freely.
>
> Finally, after getting rid of all Exynos5440 symbols, the last patch (10/10) will
> end in arm-soc tree.
>
>
> Any comments?

I don't see any hard dependency here, if this is all unused, I think we
can apply both patches 1 and 10 into arm-soc at the same time as merging
the other patches through the respective subsystem trees.

      Arnd
