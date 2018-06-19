From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Jun 2018 07:53:35 -0300
Subject: [PATCH] ARM: dts: imx53-qsb: Let the codec control MCLK pinctrl
In-Reply-To: <20180619011645.GU16091@dragon>
References: <1528160209-2849-1-git-send-email-festevam@gmail.com>
 <20180619011645.GU16091@dragon>
Message-ID: <CAOMZO5AMNw3M+1Tei9v=BWn7ptq2cJ-7zs6DONpqFtABgNP+Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Jun 18, 2018 at 10:16 PM, Shawn Guo <shawnguo@kernel.org> wrote:

> Are you saying that pins in hog group hasn't been set up yet when codec
> driver probes?

After further investigation I found the root cause as to why
pinctrl_hog pins were failling and sent a fix for it:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=fixes&id=bc3322bc166a2905bc91f774d7b22773dc7c063a

We can drop this dts patch.

Moving from hog to codec group is still a good idea though. I can
respin this patch later, but it will be a cleanup, not a bug fix.

Thanks
