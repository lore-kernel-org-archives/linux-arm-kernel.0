From: davem@davemloft.net (David Miller)
Date: Thu, 11 Apr 2013 13:31:19 -0400 (EDT)
Subject: [PATCH] net: mv643xx_eth: Add GRO support
In-Reply-To: <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
References: <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
Message-ID: <20130411.133119.913809939413807690.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Thu, 11 Apr 2013 17:27:03 +0200

> On Thu, Apr 11, 2013 at 5:03 PM, Willy Tarreau <w@1wt.eu> wrote:
>> On Thu, Apr 11, 2013 at 04:47:49PM +0200, Sebastian Hesselbarth wrote:
>>> I tried todays net-next on top of 3.9-rc6 without any gro patch, with
>>> the initial
>>> patch (Soeren) and your proposed patch (Willy). The results show that
>>> both patches
>>> allow a significant increase in throughput compared to
>>> netif_receive_skb (!gro, !lro)
>>> alone. Having gro with lro disabled gives some 2% more throughput
>>> compared to lro only.
>>
>> Indeed this is consistent with my memories, since Eric improved the
>> GRO path, it became faster than LRO on this chip.
> 
> I don't have a strong opinion on whether Soeren's or your proposal should
> be submitted. But I insist on having one of them in, as GRO significantly
> improves the common use case, is enabled by default, and not as
> constrained as LRO.

I think, as per other drivers, LRO should be eliminated completely from
all drivers, including this one, and GRO used exclusively instead.
