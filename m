From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Jun 2017 21:49:58 +0200
Subject: [PATCH] ARM: samsung: Save defconfig for Exynos,
 S3C and S5P configs
In-Reply-To: <20170607181846.13539-1-krzk@kernel.org>
References: <20170607181846.13539-1-krzk@kernel.org>
Message-ID: <CAK8P3a2_rLigHqnOkHPM+x2GDrwdGnwJOqEbY7YTsQRUXT_eJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 7, 2017 at 8:18 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Some configs for Samsung ARM SoCs were not updated for some time and
> they still contain obsolete Kconfig entries.  Generate new defconfig for
> all Samsung ARM architectures (Exynos, S3C24xx, S3C64xx, S5Pv210).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Hi Krzysztof,

Updating the defconfig files is good, but I'm always a little unsure
about loss of
information when we do that. Would it be possible for you to split this patch
into two halves, with one of them just reordering the entries that moved,
and the second one removing the entries that have disappeared, with an
explanation for why they are no longer there? That would let us see whether
the change was intentional and avoid problems from renamed Kconfig
symbols that are no longer enabled afterwards.

      Arnd
