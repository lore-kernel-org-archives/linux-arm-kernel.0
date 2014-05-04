From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 4 May 2014 13:49:23 -0400
Subject: [PATCH v2 1/9] ASoC: alc5623: Add device tree binding
In-Reply-To: <1399141819-23924-2-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
 <1399141819-23924-2-git-send-email-andrew@lunn.ch>
Message-ID: <20140504174923.GW28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 03, 2014 at 08:30:11PM +0200, Andrew Lunn wrote:
> Let the ALC5623 codec be instantiated from DT. Add a simple binding
> for the additional control register and the jack detect register.
> 
> Also, add a prompt to the Kconfig entry for this CODEC, so that it can
> be selected. Since kirkwood-t5325.c will no longer be used, we need to
> be able to enable the CODEC in the mvebu_v5_defconfig etc.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> I followed the example of the WM8903 binding which allows register
> values to be placed into DT.
> 
> v1->v2:
> 
> Add redundant OF ID table.
> Fix binding documentation.
> Fix check of return code from of_property_read_u32().
> Add Kconfig prompt
> ---
>  .../devicetree/bindings/sound/alc5623.txt          | 25 ++++++++++++++++++++++
>  sound/soc/codecs/Kconfig                           |  2 +-
>  sound/soc/codecs/alc5623.c                         | 20 +++++++++++++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt

I assume Mark is going to take this through his tree.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
