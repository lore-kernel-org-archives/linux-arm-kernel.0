From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 13:27:39 +0200
Subject: [PATCH 09/18] ASoC: sti: Update DT example to match the driver
 code
In-Reply-To: <1461236675-10176-10-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-10-git-send-email-peter.griffin@linaro.org>
Message-ID: <4337545.DyleYAUzIV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 12:04:26 Peter Griffin wrote:
> uniperiph-id, version and mode are ST specific bindings and
> need the 'st,' prefix. Update the examples, as otherwise copying
> them yields a runtime error parsing the DT node.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: arnaud.pouliquen at st.com
> ---
>  .../devicetree/bindings/sound/st,sti-asoc-card.txt         | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> index 028fa1c..ef2e0c6 100644
> --- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> @@ -67,9 +67,9 @@ Example:
>                 dmas = <&fdma0 4 0 1>;
>                 dai-name = "Uni Player #1 (DAC)";
>                 dma-names = "tx";
> -               uniperiph-id = <2>;
> -               version = <5>;
> -               mode = "PCM";
> +               st,uniperiph-id = <2>;
> +               st,version = <5>;
> +               st,mode = "PCM";
>         };

You don't change the binding desciption here, only the example,
so they no longer match.

What is st,uniperiph-id needed for anyway? It's often an indication
that you are doing something wrong if you need this.

	Arnd
