From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 14 Dec 2011 09:29:59 +0800
Subject: [PATCH V2 7/7] arm/imx6q: add cpufreq support
In-Reply-To: <CAMXH7KHxRtWAZmUSo42gwcRps=CDY3PC-ZdqWQm7Ot9xYc+LgQ@mail.gmail.com>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
 <1323757530-19402-8-git-send-email-richard.zhao@linaro.org>
 <20111213102315.GJ27267@pengutronix.de>
 <20111213103831.GG28768@b20223-02.ap.freescale.net>
 <CAMXH7KHxRtWAZmUSo42gwcRps=CDY3PC-ZdqWQm7Ot9xYc+LgQ@mail.gmail.com>
Message-ID: <20111214012958.GK28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> > +static int arm_max_freq_idx;
> >>
> >> This is only used in mx6q_get_cpu_op()
> > I'll move to local var
> >>
> >> Also shouldn't this be initialized with 1? From what you
> >> said 800MHz is safe for all boards whereas 1GHz is not.
> > I'll fix it in next version.
> >
> 
> Richard, I communicated with Hui Liu a couple of weeks ago about the
> possibility of adding a "max_freq" kernel parameter to the i.MX6q
> community u-boot, similiar to what has been done for the BSP u-boot.
> If he is or has done this, it may be better to read and use this
> kernel parameter from u-boot so that the same kernel can be used
> between boards with and without the fix.  I'm not that familiar with
> device tree yet but perhaps it provides another way to handle this.
> Also keep in
Using bootargs, it's what I did in V1 patch. I prefer that way too.

Thanks
Richard 
