From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Apr 2016 09:58:19 -0500
Subject: [PATCH 00/30] ARM: OMAP2+: hwmod module clock type support
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160412145819.GA25032@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 11:18:51AM +0300, Tero Kristo wrote:
> Hi,
> 
> This series transfers the hwmod clkctrl handling from the hwmod core
> under clock driver, the data is also transferred from hwmod data to
> devicetree. Done for most of the OMAP2+ platforms, except OMAP2 / OMAP3,
> where work is still under progress.

Some high level questions.

Why a DT node per clock? We've pretty much decided that is a bad idea 
in the complex cases. TI chips certainly fall in the complex case.

You are changing compatible strings and possibly breaking compatibility. 
Don't do that or justify why.

Rob
