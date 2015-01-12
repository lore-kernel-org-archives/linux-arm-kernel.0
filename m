From: dingtianhong@huawei.com (Ding Tianhong)
Date: Mon, 12 Jan 2015 17:04:43 +0800
Subject: [PATCH net-next v11 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <19225293.OPozO1Cbk5@wuerfel>
References: <1421049832-6224-1-git-send-email-dingtianhong@huawei.com>
 <1421049832-6224-4-git-send-email-dingtianhong@huawei.com>
 <19225293.OPozO1Cbk5@wuerfel>
Message-ID: <54B38E2B.4060105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/12 16:52, Arnd Bergmann wrote:
> On Monday 12 January 2015 16:03:52 Ding Tianhong wrote:
>> Support Hisilicon hip04 ethernet driver, including 100M / 1000M controller.
>> The controller has no tx done interrupt, reclaim xmitted buffer in the poll.
> 
> Looks great to me in the latest version. Dave, unless you have further
> concerns, please apply.
> 
>> v11: Add ethtool support for tx coalecse getting and setting, the xmit_more
>> is not supported for this patch, but I think it could work for hip04,
>> will support it later after some tests for performance better.
>>
>> Here are some performance test results by ping and iperf(add tx_coalesce_frames/users),
>> it looks that the performance and latency is more better by tx_coalesce_frames/usecs.
>>
>> - Before:
>> $ ping 192.168.1.1 ...
>> --- 192.168.1.1 ping statistics ---
>> 24 packets transmitted, 24 received, 0% packet loss, time 22999ms
>> rtt min/avg/max/mdev = 0.180/0.202/0.403/0.043 ms
>>
>> $ iperf -c 192.168.1.1 ...
>> [ ID] Interval       Transfer     Bandwidth
>> [  3]  0.0- 1.0 sec   115 MBytes   945 Mbits/sec
> 
> Just to be sure: you were running the two tests simultaneously, right?
> 
> 	Arnd
> 
Yes, sure, and try several times, record the more appropriate test results. :)

Ding

> .
> 
