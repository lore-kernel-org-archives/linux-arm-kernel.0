From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 14:48:15 -0700
Subject: [PATCH v2 1/2] ARM64: dts: rockchip: add sdhci/emmc for rk3399
In-Reply-To: <CAD=FV=UwtHu+DmJZqeWDQ8B9wMVdKODRignqDdZ4rknnmQru3g@mail.gmail.com>
References: <1463092552-60696-1-git-send-email-briannorris@chromium.org>
 <CAD=FV=UwtHu+DmJZqeWDQ8B9wMVdKODRignqDdZ4rknnmQru3g@mail.gmail.com>
Message-ID: <20160513214815.GA109473@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 02:42:06PM -0700, Doug Anderson wrote:
> On Thu, May 12, 2016 at 3:35 PM, Brian Norris <briannorris@chromium.org> wrote:
> > +               emmc_phy: phy at f780 {
> > +                       compatible = "rockchip,rk3399-emmc-phy";
> > +                       reg = <0xf780 0x20>;
> 
> This is slightly wrong.  It should be:
> 
> reg = <0xf780 0x24>;
> 
> The status register is at an offset of 0x20 and is 4 bytes big, so we
> need room for it.

Fixed.

> After that is fixed, feel free to add my Reviewed-by tag.

Done.

Thanks for the review.

Brian
