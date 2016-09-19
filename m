From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 19 Sep 2016 09:56:50 +0100
Subject: [PATCH 00/19] [RESEND] Remove STiH415 and STiH416 SoC platform
 support
In-Reply-To: <10792443.jxCOopyCy4@wuerfel>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <7524458.uFhxDUCqEo@wuerfel>
 <20160915070139.GA14319@griffinp-ThinkPad-X1-Carbon-2nd>
 <10792443.jxCOopyCy4@wuerfel>
Message-ID: <20160919085650.GA4948@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, 15 Sep 2016, Arnd Bergmann wrote:

> On Thursday, September 15, 2016 8:01:39 AM CEST Peter Griffin wrote:
> > 
> > STiH415 I'm sure never shipped. I'm reasonably sure STiH416 didn't
> > either. These SoCs were considered legacy even when I was at ST
> > ~3 years ago.
> > 
> > Also remember these are STB SoC's, so JTAG fuses are blown in
> > production boxes, and also full security is enabled. This means the
> > primary bootloader will only boot a signed kernel. So if a end user
> > did happen to have a box they would be unable to upgrade their kernel.
> > 
> > From the landing team perspective they were interesting in that they
> > shared many IPs with the STiH407 family on which future chipsets were
> > based, and were available to us when that silicon was harder to get
> > hold of. So we used it as a vehicle for upstreaming so that upstream
> > support was already quite good when STiH407 silicon did land on our
> > desk.
> 
> Ok, makes sense. I did stumble over one machine basedon STiH412
> the other day [1], but there probably isn't much shared with that
> one. Since this a NAS server rather than an STB box, it's probably
> less locked-down and potentially a target for OpenWRT or similar.

I just double checked with ST and STiH412 is a STiH407 family based SoC
so support still exists for this upstream. No idea what if any security is
enabled on this product though.

Most probably the A/V stack on it will be SDK2, although native upstream
multimedia drivers for this chipset are looking pretty good now.

Peter.

> [1] http://www.heise.de/preisvergleich/synology-diskstation-ds216play-16tb-a1400885.html
