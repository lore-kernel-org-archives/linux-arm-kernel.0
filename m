From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Mar 2014 11:40:57 +0100
Subject: [PATCH 0/5] ARM: shmobile: r8a7790: enable IIC(B) cores
In-Reply-To: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
Message-ID: <2570845.PngjMN9sWk@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tuesday 11 March 2014 22:24:33 Wolfram Sang wrote:
> This series allows r8a7790 boards to use the alternative IIC(B) controller
> handled by the i2c-sh_mobile driver. Since both i2c cores always use the
> same pins only in a different function group, you can easily use this or
> that core for your devices. For that reason, there is currently no
> enablement on the Lager board, since it needs discussion which core we want
> to have on which bus. sh_mobile seems more stable currently, so I'd vote
> for that.

Do you have a short list of pros and cons from a hardware point of view ?

> Please review and apply if no issues found.
> 
> Thanks,
> 
>    Wolfram
> 
> 
> Wolfram Sang (5):
>   pinctrl: pfc: r8a7790: add i2c0 muxing
>   pinctrl: pfc: r8a7790: add mux data for IIC(B) cores
>   ARM: shmobile: r8a7790: add IIC0-2 clock macros
>   ARM: shmobile: r8a7790: add IIC(B) clocks to dtsi
>   ARM: shmobile: r8a7790: add IIC(B) cores to dtsi
> 
>  arch/arm/boot/dts/r8a7790.dtsi            |  71 +++++++++++++---
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c      | 136 ++++++++++++++++++++++++++-
>  include/dt-bindings/clock/r8a7790-clock.h |   3 +
>  3 files changed, 196 insertions(+), 14 deletions(-)

-- 
Regards,

Laurent Pinchart
