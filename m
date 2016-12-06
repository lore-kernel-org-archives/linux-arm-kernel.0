From: robh@kernel.org (Rob Herring)
Date: Tue, 6 Dec 2016 09:52:07 -0600
Subject: [PATCH 2/2] ASoC: atmel: tse850: rely on the ssc to register as
 a cpu dai by itself
In-Reply-To: <1480593549-6464-3-git-send-email-peda@axentia.se>
References: <1480593549-6464-1-git-send-email-peda@axentia.se>
 <1480593549-6464-3-git-send-email-peda@axentia.se>
Message-ID: <20161206155207.jmybycruwsyplabr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 12:59:09PM +0100, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/sound/axentia,tse850-pcm5142.txt      |  5 ++---
>  sound/soc/atmel/tse850-pcm5142.c                   | 23 +++-------------------
>  2 files changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
> index 5b9b38f578bb..fd12ecb35b5c 100644
> --- a/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
> +++ b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
> @@ -2,8 +2,7 @@ Devicetree bindings for the Axentia TSE-850 audio complex
>  
>  Required properties:
>    - compatible: "axentia,tse850-pcm5142"
> -  - axentia,ssc-controller: The phandle of the atmel SSC controller used as
> -    cpu dai.
> +  - axentia,cpu-dai: The phandle of the cpu dai.

You are breaking backwards compatibility with old DTBs. You either need 
to not do that or explain in the commit why that is okay.

Rob
