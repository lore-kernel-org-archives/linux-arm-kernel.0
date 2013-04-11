From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 11 Apr 2013 17:27:03 +0200
Subject: [PATCH] net: mv643xx_eth: Add GRO support
In-Reply-To: <20130411150326.GA19978@1wt.eu>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
Message-ID: <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 5:03 PM, Willy Tarreau <w@1wt.eu> wrote:
> On Thu, Apr 11, 2013 at 04:47:49PM +0200, Sebastian Hesselbarth wrote:
>> I tried todays net-next on top of 3.9-rc6 without any gro patch, with
>> the initial
>> patch (Soeren) and your proposed patch (Willy). The results show that
>> both patches
>> allow a significant increase in throughput compared to
>> netif_receive_skb (!gro, !lro)
>> alone. Having gro with lro disabled gives some 2% more throughput
>> compared to lro only.
>
> Indeed this is consistent with my memories, since Eric improved the
> GRO path, it became faster than LRO on this chip.

I don't have a strong opinion on whether Soeren's or your proposal should
be submitted. But I insist on having one of them in, as GRO significantly
improves the common use case, is enabled by default, and not as
constrained as LRO.

Sebastian
