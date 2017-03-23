From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Thu, 23 Mar 2017 10:40:15 +0000
Subject: stmmac: Performance regression after commit aff3d9eff843 "net:
 stmmac: enable multiple buffers"
In-Reply-To: <20170323102037.GD16625@Red>
References: <20170323100828.GC16625@Red>
 <68200e05-04fd-1cc1-f6d6-f77e9e6f1d9d@synopsys.com>
 <20170323102037.GD16625@Red>
Message-ID: <a7c928ec-e4e5-b618-d0d4-2a833be10d53@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?s 10:20 AM de 3/23/2017, Corentin Labbe escreveu:
> On Thu, Mar 23, 2017 at 10:12:18AM +0000, Joao Pinto wrote:
>>
>> Hi Corentin,
>>
>> ?s 10:08 AM de 3/23/2017, Corentin Labbe escreveu:
>>> Hello
>>>
>>> Using next-20170323 produce a huge performance regression on my sunxi boards.
>>> On dwmac-sun8i, iperf goes from 94mbs/s to 37 when sending.
>>>
>>> On cubieboard2(dwmac-sunxi), iperf made the kernel flood with "ndesc_get_rx_status: Oversized frame spanned multiple buffers"
>>> and network is lost after.
>>>
>>> Reverting aff3d9eff84399e433c4aca65a9bb236581bc082 fix the issue.
>>> I still try to found which part of this patch mades the performance lower.
>>>
>>> Regards
>>> Corentin Labbe
>>>
>>
>> I have a 4.21 QoS Core with 4 RX + 4 TX and detected no regression.
>> Could you please share the iperf cmds you are using in order for me to reproduce
>> in my side?
> 
> simple iperf -c serverip for both board
> 

Ok, I am going to run my tests with a fresh net-next and come back to you soon.

Thanks,
Joao
