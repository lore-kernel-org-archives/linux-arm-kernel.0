From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Thu, 23 Mar 2017 10:54:48 +0000
Subject: stmmac: Performance regression after commit aff3d9eff843 "net:
 stmmac: enable multiple buffers"
In-Reply-To: <465dc72e-8a1f-b41f-105f-add2164df6d5@st.com>
References: <20170323100828.GC16625@Red>
 <68200e05-04fd-1cc1-f6d6-f77e9e6f1d9d@synopsys.com>
 <20170323102037.GD16625@Red>
 <a7c928ec-e4e5-b618-d0d4-2a833be10d53@synopsys.com>
 <465dc72e-8a1f-b41f-105f-add2164df6d5@st.com>
Message-ID: <3df02ae0-f38a-9184-5ad7-d7afc9b51a97@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Peppe,

?s 10:48 AM de 3/23/2017, Giuseppe CAVALLARO escreveu:
> Hello
> 
> On 3/23/2017 11:20 AM, Corentin Labbe wrote:
>>> I have a 4.21 QoS Core with 4 RX + 4 TX and detected no regression.
>>> >Could you please share the iperf cmds you are using in order for me to
>>> reproduce
>>> >in my side?
> 
> Joao, you have a really powerful HW integration with multiple channels for both
> RX and TX.
> Often this is not the same for other setup where, usually just a DMA0 is present
> or, sometime, there
> is just one RX extra channel.

My opinion is that we should not have problems, since the majority of features
introduced are used if you configure rx queues > 1 or tx queues > 1, so if you
use the default (=1) those confiogurations will not take place.

> 
> My question is, what happens on this kind of configurations? Are we still
> guarantying the best performances?
> 
> Also we have to guarantee, that the TSO and SG are always working. Another point
> is the buffer sizes that
> can be different among platforms.

We have to pay attention to the RX buffer size, since I had problems with DHCP
messages not being received because of little buffer size.
Currently TX buffer size is not configurable and in the future it should be
useful to include it too.

> 
> The problem  below reported by Corentin push me to think that there is a bug, so
> we should
> understand when this has been introduced and if likely fixed by some
> configuration we are
> not take care right now.

Of course.

> 
> ndesc_get_rx_status: Oversized frame spanned multiple buffers"
> 
> 
> Best Regards
> Peppe

Thanks,
Joao
