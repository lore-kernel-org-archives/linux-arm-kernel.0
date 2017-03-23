From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Thu, 23 Mar 2017 10:12:18 +0000
Subject: stmmac: Performance regression after commit aff3d9eff843 "net:
 stmmac: enable multiple buffers"
In-Reply-To: <20170323100828.GC16625@Red>
References: <20170323100828.GC16625@Red>
Message-ID: <68200e05-04fd-1cc1-f6d6-f77e9e6f1d9d@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Corentin,

?s 10:08 AM de 3/23/2017, Corentin Labbe escreveu:
> Hello
> 
> Using next-20170323 produce a huge performance regression on my sunxi boards.
> On dwmac-sun8i, iperf goes from 94mbs/s to 37 when sending.
> 
> On cubieboard2(dwmac-sunxi), iperf made the kernel flood with "ndesc_get_rx_status: Oversized frame spanned multiple buffers"
> and network is lost after.
> 
> Reverting aff3d9eff84399e433c4aca65a9bb236581bc082 fix the issue.
> I still try to found which part of this patch mades the performance lower.
> 
> Regards
> Corentin Labbe
> 

I have a 4.21 QoS Core with 4 RX + 4 TX and detected no regression.
Could you please share the iperf cmds you are using in order for me to reproduce
in my side?

@stmmac users: It would be great if people that have a setup could also perform
teh same iperf test in order to clean in up for everyone.

Thanks,
Joao
