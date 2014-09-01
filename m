From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 1 Sep 2014 15:34:12 +0200
Subject: [PATCHv1 1/7] ASoC: simple-card: Merge single and muti DAI link
 code.
In-Reply-To: <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20140901133412.GA11312@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 12:29:35PM +0800, Xiubo Li wrote:
> This patch merge single DAI link and muti-DAI links code together,
> and simply the simple-card driver code.

Hi Xiubo

It would be good to note that this breaks the Binary API with DT
blobs. Old blobs will not work with this new C code.

> And also do some other improvement:

It would be good to put these improvements into separate patches,
making them easier to review.

> +====
> +DAI link node(s) and its or their subnodes:
>  
> -Required dai-link subnodes:
> +There must be one DAI link node exsit at least, and each DAI link must

typ0. It would also be better to say:

There must be at least one DAI link, and each DAI link must

> +contain one CPU subnode and one CODEC subnode.

  Andrew
