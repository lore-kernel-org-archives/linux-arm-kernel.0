From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Sep 2011 13:14:38 -0700
Subject: [PATCH 3/3] arm/tegra: Move "gpio-names.h" into
	<mach/gpio-tegra.h>
In-Reply-To: <1316633620-13184-3-git-send-email-swarren@nvidia.com>
References: <1316633620-13184-1-git-send-email-swarren@nvidia.com>
	<1316633620-13184-3-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMhdkrtjvXWHhbLSj804s+CzTthn_hrGafp5K=Va5MTZ=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 21, 2011 at 12:33 PM, Stephen Warren <swarren@nvidia.com> wrote:
> This centralizes all SoC-level GPIO-related definitions into a single
> header file.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>
> ?arch/arm/mach-tegra/gpio-names.h ? ? ? ? ? ? ?| ?247 -------------------------
> ?arch/arm/mach-tegra/include/mach/gpio-tegra.h | ?225 ++++++++++++++++++++++
> ?11 files changed, 226 insertions(+), 257 deletions(-)
> ?delete mode 100644 arch/arm/mach-tegra/gpio-names.h

The main reason that gpio-names.h was only in the mach directory and
not under include in the first place, is to discourage use outside of
the base platform code and board definitions.

There should be no need for drivers and non-mach-tegra code to use the
file, so doing a current-directory include of it should be OK. Or do
you have other plans for it?


-Olof
