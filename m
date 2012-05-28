From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 May 2012 12:27:29 -0300
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <1338084735-12083-1-git-send-email-marex@denx.de>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5C-XbGqWHxpX24V6X58rcnSeSobuyJNiZTJErQi55tEbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, May 26, 2012 at 11:12 PM, Marek Vasut <marex@denx.de> wrote:

> + ? ? ? sound {
> + ? ? ? ? ? ? ? compatible = "fsl,imx28-evk-sgtl5000",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?"fsl,mxs-audio-sgtl5000";
> + ? ? ? ? ? ? ? model = "imx28-evk-sgtl5000";
> + ? ? ? ? ? ? ? saif-controllers = <&saif0 &saif1>;
> + ? ? ? ? ? ? ? audio-codec = <&sgtl5000>;
> + ? ? ? };
> +};

Shouldn't this be:

sound {
	compatible = "fsl,imx28-m28-sgtl5000",
		     "fsl,mxs-audio-sgtl5000";
	model = "imx28-m28-sgtl5000";
	saif-controllers = <&saif0 &saif1>;
	audio-codec = <&sgtl5000>;
};
