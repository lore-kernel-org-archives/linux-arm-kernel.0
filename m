From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Dec 2014 16:16:40 +0100
Subject: [linux-sunxi] Re: [PATCH 01/10] clk: sunxi: Add module 0
 (storage) style clock support for A80
In-Reply-To: <CAGb2v66iE2OzYEV6YxE=3-6MLSOzXHRwYfSSMGcq00VwmwS=mw@mail.gmail.com>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-2-git-send-email-wens@csie.org>
 <20141206171322.GB12434@lukather>
 <CAGb2v66iE2OzYEV6YxE=3-6MLSOzXHRwYfSSMGcq00VwmwS=mw@mail.gmail.com>
Message-ID: <20141207151640.GJ12434@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 07, 2014 at 09:13:46AM +0800, Chen-Yu Tsai wrote:
> > (Which makes me wonder why do we the same spinlock for all the
> > instances of the mod0 clocks, but that's another story)
> 
> Are you worried about contention? AFAIK we don't do anything
> fancy in our code that would result in a major problem.
> I was wondering the same thing a while ago.

Yes. While I'm not overly concerned about a performance bottleneck, it
does seems a bit odd to have a shared lock when there's no shared
resources.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141207/a2295bc8/attachment.sig>
