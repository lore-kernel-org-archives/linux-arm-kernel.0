From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 3 Feb 2013 20:50:13 -0500
Subject: [PATCH v2] rtc: rtc-mv: Add support for clk to avoid lockups
In-Reply-To: <1359891126-21909-1-git-send-email-andrew@lunn.ch>
References: <1359891126-21909-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130204015013.GJ14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 03, 2013 at 12:32:06PM +0100, Andrew Lunn wrote:
> The Marvell RTC on Kirkwood makes use of the runit clock. Ensure the
> driver clk_prepare_enable() this clock, otherwise there is a danger
> the SoC will lockup when accessing RTC registers with the clock
> disabled.
> 
> Reported-by: Simon Baatz gmbnomis at gmail.com
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> Since v1:
> Enable clock before accessing RTC registers.
> 
>  arch/arm/boot/dts/kirkwood.dtsi |    1 +
>  drivers/rtc/rtc-mv.c            |   28 ++++++++++++++++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)

Applied to mvebu/fixes with Simon's Tested-by: and added '<' '>' to the
Reported-by:.

thx,

Jason.
