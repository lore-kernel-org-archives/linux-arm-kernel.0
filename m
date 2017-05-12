From: robh@kernel.org (Rob Herring)
Date: Fri, 12 May 2017 10:24:52 -0500
Subject: [PATCH 1/4] ata: Add DT bindings for Faraday Technology FTIDE010
In-Reply-To: <20170506121053.11554-1-linus.walleij@linaro.org>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
Message-ID: <20170512152452.jps5akmsxuvovugy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06, 2017 at 02:10:50PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the Faraday Technology
> FTIDE010 found in the Storlink/Storm/Cortina Systems Gemini SoC.
> 
> I am not 100% sure that this part if from Faraday Technology but

s/if/is/

> a lot points in that direction:
> 
> - A later IDE interface called FTIDE020 exist and share some
>   properties.
> 
> - The SATA bridge has the same Built In Self Test (BIST) that the
>   Faraday FTSATA100 seems to have, and it has version number 0100
>   in the device ID register, so this is very likely a FTSATA100
>   bundled with the FTIDE010.
> 
> Cc: devicetree at vger.kernel.org
> Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Greentime: I think this may be interesting to you since the
> FTIDE020 will need the same bindings so we can probably
> just reuse them and maybe make the parser a library if you
> want to upstream the FTIDE020.
> 
> Faraday people: I do not have it from a source that this
> hardware is really FTIDE010 but I would be VERY surprised
> if it is not. U-Boot has an FTIDE020 IDE controller
> synthesized in the Andestech platform, and it has a similar
> yet different register layout, featuring similar timing
> set-ups:
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/block/ftide020.h
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/block/ftide020.c
> ---
>  .../devicetree/bindings/ata/faraday,ftide010.txt   | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt

Acked-by: Rob Herring <robh@kernel.org>
