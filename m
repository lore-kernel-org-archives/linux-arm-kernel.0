From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Jun 2013 07:28:28 -0300
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <20130625081227.GA12178@S2101-09.ap.freescale.net>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
 <CAOMZO5DUsGpffGOkEjZX3JaKcJxV6GsH_pOyX=dhHxq3vB9xQA@mail.gmail.com>
 <201306221524.33879.marex@denx.de>
 <CAOMZO5DYNmiasRREC8jXH===2HG1aNvpxpFVU2u+q5ZAT8Wd3Q@mail.gmail.com>
 <20130624072908.GH26254@S2101-09.ap.freescale.net>
 <CAOMZO5Bfetjwinatj4W-nrEvg+3pLfjgF8Zpx_-=n52ZTGHeGA@mail.gmail.com>
 <20130624140754.GF30747@S2101-09.ap.freescale.net>
 <CAOMZO5Ds3ZBhunOh1BSjLz7g=-3mRz_CwpgsPVnabGr=XzMx4g@mail.gmail.com>
 <20130625081227.GA12178@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Ch+kp4kzc_-aghZz3yMeXYYsKXiiaFrxVJnYF+BCFTbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 5:12 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Oh, look at this line, you have the clock work for sgtl5000.  So it
> seems that sgtl5000_i2c_probe() fails at somewhere else on the second
> try.

Yes, I noticed that. Codec revision is read succesfully in the second
attempt, but
snd_soc_register_card() still returns -517 (-EPROBE_DEFER).
