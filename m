From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 May 2014 13:13:53 -0700
Subject: [linux-sunxi] [PATCH v2 1/4] dt: bindings: mmc: Document the
 practice of using subnodes for slots
In-Reply-To: <1401563014-13856-2-git-send-email-hdegoede@redhat.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
 <1401563014-13856-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAOesGMisqtPWKY6N5ch36c0VyBP1Pu725cehBU+2gYtKXQs=hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 12:03 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The following existing MMC host controller bindings use slot subnodes:
>
> Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
>
> This commit documents this practice in the standard mmc bindings documentation.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

There are today only two drivers that use this kind of binding, dw_mmc
and the at91 one. Neither seems to actually ever have been used with
more than one slot. I doubt anyone building an exynos-based system
will ever do a multi-slot solution, and it seems that the at91 driver
doesn't actually handle more than one slot.

I'm personally not that excited about complicating the bindings by
opening up for this -- I would rather work towards removing the
concept of slots if it's one of those things that are going to remain
unused. We have actually been talking about reworking the dw_mmc
binding to remove the slot concept (and simplify the driver by doing
so).


-Olof
