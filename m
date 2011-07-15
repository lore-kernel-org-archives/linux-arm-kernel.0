From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 15 Jul 2011 23:02:36 +0800
Subject: [alsa-devel] [PATCH V2 06/10] ARM: mxs: add saif device
In-Reply-To: <20110715133241.GG2021@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-7-git-send-email-b29396@freescale.com>
	<20110715133241.GG2021@pengutronix.de>
Message-ID: <CAA+hA=TtBrDoAMfv0fqj30_heEJuZJFH=QjTUG8zTys0G+vgvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/15 Wolfram Sang <w.sang@pengutronix.de>:
>> +#define DIGCTRL_BASE_ADDR ? ? ?MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
>> +
>
> Hmm, maybe define a function mx28_set_saif_clkmux(val)?
>
>> + ? ? mx28_add_saif(0);
>> + ? ? mx28_add_saif(1);
>> +
>> + ? ? /*set the saif clk mux, both saif0/saif1 use saif0 clk*/
>> + ? ? __raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);
>
> You might overwrite previous settings here. The hardcoded numbers need
> defines, too.

It's correct.
I'm originally going to do that when implement record because this
setting may affect both
machine driver and saif driver on recording.
Since currently we only implement playback, so i just hardcode it.
Do you think if that's ok?
Or i need to do it now?

Regards
Dong Aisheng
