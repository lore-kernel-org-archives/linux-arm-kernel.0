From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 23:52:06 +0100
Subject: [RFC PATCH 04/11] PCI: tegra: limit to MMU build only
In-Reply-To: <d9fd3fab-d648-0664-bd73-994bebf36bf4@wwwdotorg.org>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <4182371.efWsDqfOeS@wuerfel>
 <d9fd3fab-d648-0664-bd73-994bebf36bf4@wwwdotorg.org>
Message-ID: <3175374.ys6NksbXAK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 3:27:35 PM CET Stephen Warren wrote:
> On 11/22/2016 02:16 PM, Arnd Bergmann wrote:
> > On Tuesday, November 22, 2016 9:15:13 AM CET Stephen Warren wrote:
> >> On 11/22/2016 02:26 AM, Vladimir Murzin wrote:
> >>> This driver uses functionality which available for MMU build only,
> >>> thus add dependency on MMU.
> >>
> >> I'd expect ARCH_TEGRA to depend on MMU instead.
> >>
> >
> > Any particular reason for why we'd single out Tegra?
> 
>  From the cover letter, it sounded like the point of the series was to 
> all !MMU builds for a bunch of SoCs with M-class cores. Tegra doesn't 
> have an M-class core so I wouldn't expect it to be included in such a 
> build. I'd expect the same fix that I suggested to apply to all 
> non-M-class SoCs, rather than fixing up individual drivers to depend on 
> !MMU.

I think you misread that, the point is to get NOMMU support back for
machines other than ARMv7-M, the Cortex-M based machines already work
without this.

	Arnd
