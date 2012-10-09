From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Oct 2012 01:21:10 -0300
Subject: [alsa-devel] [PATCH v2 1/2] ARM: imx: clk: Split SSI clock into
 'ipg' and 'per'
In-Reply-To: <CAOMZO5ACVeMwGcjSXcEqyHMc9G3KgyrL-uC=wvjmf1AQOAhgWQ@mail.gmail.com>
References: <1349725213-11354-1-git-send-email-fabio.estevam@freescale.com>
 <20121008214452.GA27665@pengutronix.de>
 <CAOMZO5ACVeMwGcjSXcEqyHMc9G3KgyrL-uC=wvjmf1AQOAhgWQ@mail.gmail.com>
Message-ID: <CAOMZO5Beug=Db4_dW9ziNs-M=wUizrRSrDXMAXi0CXpUO1Nvzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

On Mon, Oct 8, 2012 at 8:47 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Sascha,
>
> On Mon, Oct 8, 2012 at 6:44 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
>> I am not sure it's good to work around that issue in the ssi driver. We
>> could also just enable the clock in the clk driver as it seems to be a
>> ccm related issue.
>
> Yes, it would be better if we could fix this in clk-imx27 instead, but
> I was not able to provide such fix yet.

The ssi1_sel clock is defined as:

clk[ssi1_sel] = imx_clk_mux("ssi1_sel", CCM_CSCR, 22, 1, ssi_sel_clks,
ARRAY_SIZE(ssi_sel_clks));

,where ssi_sel_clks is:
static const char *ssi_sel_clks[] = { "spll", "mpll", }

,which matches with the mx27 reference manual.

How do we tell the clk api to select spll or mpll as the source for ssi_sel?

I understand how to do this from register level, but not from the api.

Thanks,

Fabio Estevam
