From: ning.n.jiang@gmail.com (Ning Jiang)
Date: Tue, 23 Oct 2012 10:55:23 +0800
Subject: Is it too strict for VIPT cache flushing in
 flush_cache_[mm|range]?
In-Reply-To: <CAH3Oq6SRSeXfrW56j=brCOE5PJgfw31rOSCfm-CgJwGaiJYRsw@mail.gmail.com>
References: <CAH3Oq6SRSeXfrW56j=brCOE5PJgfw31rOSCfm-CgJwGaiJYRsw@mail.gmail.com>
Message-ID: <CAH3Oq6Sd7OTyntiOpbiUBTcuXMNfjq17eACkN=f=91wG7BPJEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/16 Ning Jiang <ning.n.jiang@gmail.com>:
> I found that the implementation of flush_cache_mm() and
> flush_cache_range() for VIPT aliasing case is to clean + invalidate
> whole data cache, but for a physically tagged cache, why do we need to
> perform such an operation? Is it because we'll have aliasing issue?
>
> I searched through the git history and found it is brought in the
> commit "d7b6b358"  "[ARM] Fix ARMv6 VIPT cache >= 32K", before that,
> there is indeed no flushing, why we "Fix ARMv6 VIPT cache >= 32K"?
>
> Sorry for asking such stupid question, but it really confuses me ;-)
>
> Thanks,
> Ning

Maybe someone in the mail list can give an answer ;-)
