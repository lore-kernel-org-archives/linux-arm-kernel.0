From: w@1wt.eu (Willy Tarreau)
Date: Thu, 11 Apr 2013 18:02:58 +0200
Subject: [PATCH] net: mv643xx_eth: Add GRO support
In-Reply-To: <1365695675.3887.165.camel@edumazet-glaptop>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411153256.GH1910@1wt.eu> <1365695675.3887.165.camel@edumazet-glaptop>
Message-ID: <20130411160258.GI1910@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 08:54:35AM -0700, Eric Dumazet wrote:
> On Thu, 2013-04-11 at 17:32 +0200, Willy Tarreau wrote:
> > On Thu, Apr 11, 2013 at 05:27:03PM +0200, Sebastian Hesselbarth wrote:
> > > I don't have a strong opinion on whether Soeren's or your proposal should
> > > be submitted. But I insist on having one of them in, as GRO significantly
> > > improves the common use case, is enabled by default, and not as
> > > constrained as LRO.
> > 
> > I agree, use yours first, but we should keep an eye on this. Since you have
> > everything to run a test, please try to see if you can get netperf to run
> > over IPv6, I'm sure the NIC doesn't handle it.
> 
> Willy, testing the checksum in the NIC driver itself prevents the stack
> doing GRO even if the NIC could not checksum the packet, as in GRE
> tunneling for example.
> 
> So Sebastien patch is better IMHO : Just call the napi gro handler and
> let core stack handles the details ;)

OK, that makes sense indeed, I didn't think about this case. All
I remember was that the old call achieved a higher packet rate
than napi_gro_receive, but it was on an older kernel and I can't
be more specifics after several months :-/

Cheers,
Willy
