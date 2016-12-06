From: robh@kernel.org (Rob Herring)
Date: Tue, 6 Dec 2016 09:16:35 -0600
Subject: [PATCH 1/2] misc: atmel-ssc: register as sound DAI if
 #sound-dai-cells is present
In-Reply-To: <1480593549-6464-2-git-send-email-peda@axentia.se>
References: <1480593549-6464-1-git-send-email-peda@axentia.se>
 <1480593549-6464-2-git-send-email-peda@axentia.se>
Message-ID: <20161206151635.psckjlu2pyzjm7k6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 12:59:08PM +0100, Peter Rosin wrote:
> The SSC is currently not usable with the ASoC simple-audio-card, as
> every SSC audio user has to build a platform driver that may do as
> little as calling atmel_ssc_set_audio/atmel_ssc_put_audio (which
> allocates the SSC and registers a DAI with the ASoC subsystem).
> 
> So, have that happen automatically, if the #sound-dai-cells property
> is present in devicetree, which it has to be anyway for simple audio
> card to work.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/misc/atmel-ssc.txt         |  2 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/misc/atmel-ssc.c                           | 50 ++++++++++++++++++++++
>  include/linux/atmel-ssc.h                          |  1 +
>  3 files changed, 53 insertions(+)
