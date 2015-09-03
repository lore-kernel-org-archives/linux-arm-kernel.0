From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 03 Sep 2015 15:52:48 +0200
Subject: [PATCH v4 10/16] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <55E7BD8C.5070803@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJG3wGO3PC2raWvc588rrwF-zHD9+3WwBJxEwntm19k7Q@mail.gmail.com>
 <55E7BD8C.5070803@rock-chips.com>
Message-ID: <3242714.Wxby7z5YyH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. September 2015, 11:25:00 schrieb Yakir Yang:
> ? 09/02/2015 09:27 PM, Rob Herring ??:
> > On Tue, Sep 1, 2015 at 1:04 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> >> +- clocks: from common clock binding: handle to dp clock.
> >> +       of memory mapped region.
> >> +- clock-names: from common clock binding:
> >> +       Required elements: "sclk_dp" "sclk_dp_24m"
> >> +
> >> +- rockchip,grf: this soc should set GRF regs, so need get grf here.
> > 
> > I have no idea what GRF means.
> 
> GRF is an module of our IC chip, the full name is General Register Files.
> I would rather to pick some words from our TRM.
> 
> The general register file will be used to do static set by software, which
> is composed of many registers for system control.

The general register files are present on all Rockchip SoCs I've seen so far 
and really are just an aggregation of registers for settings and status 
indications, ranging from memory stuff, dma-controller settings, usb-phy and 
settings for a lot of other phys, etc.

The most prevalent description in dt-bindings is currently:

- rockchip,grf: phandle to the syscon managing the "general register files"


Heiko
