From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 11 Apr 2013 09:10:44 -0700
Subject: [PATCH] net: mv643xx_eth: Add GRO support
In-Reply-To: <20130411160258.GI1910@1wt.eu>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411153256.GH1910@1wt.eu> <1365695675.3887.165.camel@edumazet-glaptop>
 <20130411160258.GI1910@1wt.eu>
Message-ID: <1365696644.3887.172.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-11 at 18:02 +0200, Willy Tarreau wrote:

> OK, that makes sense indeed, I didn't think about this case. All
> I remember was that the old call achieved a higher packet rate
> than napi_gro_receive, but it was on an older kernel and I can't
> be more specifics after several months :-/

Its probably true that the GRO handler consumes more cpu for packets
that cant be aggregated in the end.

Thats a trade off, and maybe we could add in the core stack a device
feature to instruct gro handler to do a short cut for packets with no
checksum. Or better a sysctl so that a static_branch can be used.
