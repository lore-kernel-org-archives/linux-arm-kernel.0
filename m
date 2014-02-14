From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Feb 2014 18:06:12 +0100
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <CAOesGMgdDnSc=Y8i6JYeGewCh1RPYZ_AxocxKzSD265fa2-yrA@mail.gmail.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <52F99056.6010906@samsung.com>
 <CAOesGMgdDnSc=Y8i6JYeGewCh1RPYZ_AxocxKzSD265fa2-yrA@mail.gmail.com>
Message-ID: <201402141806.12711.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 February 2014, Olof Johansson wrote:
> On Mon, Feb 10, 2014 at 6:52 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > On 02/13/14 04:14, Arnd Bergmann wrote:
> >> On Wednesday 12 February 2014 13:04:40 Kumar Gala wrote:
> > Basically, I agreed with Arnd's suggestion to use ARCH_SBSA. Or we need to
> > define level in Kconfig like ARCH_SBSA_L1 for level1. BTW, how about
> > compliant with SBSA Level1 and having some specific features?

My feeling is that we don't need to use the levels for Kconfig, although
we might want to use them DT compatible strings, even if it ends up looking
a little funny when you do 

	compatible = "arm,sbsa-l3", "arm,sbsa-l2", "arm,sbsa-l1";

> What kind of features are you expecting though? More IP
> blocks/devices? Those are just kernel config options to enable,
> ideally as modules.

Right, I think we can just put them into defconfig. No need to
"select" them from Kconfig since the extra options wouldn't be
required for booting or using the system.

	Arnd
