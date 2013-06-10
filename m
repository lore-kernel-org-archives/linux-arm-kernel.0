From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Jun 2013 13:07:18 -0300
Subject: [PATCH 1/2] ASoC: sgtl5000: Let the codec acquire its clock
In-Reply-To: <20130610154126.GF6381@S2101-09.ap.freescale.net>
References: <1370826467-30399-1-git-send-email-festevam@gmail.com>
 <20130610154126.GF6381@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5B9fsC9UMsdbXMMSJzG_r=-U8o9nr=j9r_GxkeVMoa8og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 12:41 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> -clk_fail:
>> -     clk_put(data->codec_clk);
>
> Why can this clk_put() be removed now?

Good point. Will send a patch to convert it to devm_clk_get, so that
we do not need to call these clk_put.
