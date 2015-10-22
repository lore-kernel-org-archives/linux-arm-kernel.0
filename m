From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Oct 2015 09:54:11 -0700
Subject: [PATCH v2] ARM: dts: fix gpio-keys wakeup-source property
In-Reply-To: <1445011296-29042-1-git-send-email-sudeep.holla@arm.com>
References: <1445011296-29042-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20151022165411.GD19953@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 05:01:36PM +0100, Sudeep Holla wrote:
> The keyboard driver for GPIO buttons(gpio-keys) checks for one of the
> two boolean properties to enable gpio buttons as wakeup source:
> 1. "wakeup-source" or
> 2. the legacy "gpio-key,wakeup"
> 
> However juno, ste-snowball and emev2-kzm9d dts file have a undetected
> "wakeup" property to indictate the wakeup source.
> 
> This patch fixes it by making use of "wakeup-source" property.
> 
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Acked-by: Simon Horman <horms@verge.net.au>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/emev2-kzm9d.dts             |  8 ++++----
>  arch/arm/boot/dts/ste-snowball.dts            | 10 +++++-----
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 12 ++++++------
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> Hi ARM-SoC group,
> 
> Please consider this as a fix for v4.3 if possible.

Applied now, thanks.


-Olof
