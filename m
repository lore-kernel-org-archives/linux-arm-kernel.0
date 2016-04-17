From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 17 Apr 2016 19:12:27 +0100
Subject: [RFC PATCH] arm64: defconfig: add config fragment for Freescale
 SoCs
In-Reply-To: <CABtop_F_SkKm6H-mtpK-GHDA3PBg_RTfw=CJeewV-LLEN0SHzA@mail.gmail.com>
References: <1460643685-13670-1-git-send-email-stuart.yoder@nxp.com>
 <20160414170433.GF15182@e104818-lin.cambridge.arm.com>
 <CABtop_F_SkKm6H-mtpK-GHDA3PBg_RTfw=CJeewV-LLEN0SHzA@mail.gmail.com>
Message-ID: <20160417181224.GA5495@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 17, 2016 at 05:10:42PM +0800, Martinez Kristofer wrote:
> On Fri, Apr 15, 2016 at 1:04 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Apr 14, 2016 at 09:21:25AM -0500, Stuart Yoder wrote:
> >> The proposal is to allow a chip vendor 1 vendor-specific kconfig fragment
> >> to cover all their chips, allowing them to _override_ the default config
> >> options in defconfig.  One specific issue we have is that due to the ls2080a
> >> physical address map, the combination of 4KB pages and 39-bit VA does not
> >> allow us to see all our DDR.  And, thus we need CONFIG_ARM64_VA_BITS_48=y.
> >
> > And I'm fine to add this to defconfig. We had a case for Seattle needing
> > 48-bit VA but we eventually decoupled the number of levels for idmap and
> > swapper. If it can't be addressed in a similar way on ls2080a, we may
> > need to increase the VA space to 48-bit.
> 
> Here my suggestion is 48-bit VA will be depended on the CONFIG_ACPI,
> IOW, if CONFIG_ACPI
> is seleceted, then CONFIG_ARM64_VA_BITS_48 will be selected too.

I don't see why 48-bit VA should depend on CONFIG_ACPI, they are
unrelated options. Anyway, we are going to enable ACPI in the arm64
defconfig, so you get both.

-- 
Catalin
