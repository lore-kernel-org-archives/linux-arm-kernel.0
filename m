From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Oct 2014 09:13:23 +0100
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141031072030.GA7563@gondor.apana.org.au>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
 <20141021191149.GQ21108@lukather> <544A9FEA.6020304@gmail.com>
 <20141030171933.GR21251@lukather>
 <20141031072030.GA7563@gondor.apana.org.au>
Message-ID: <20141031081323.GS21251@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 03:20:30PM +0800, Herbert Xu wrote:
> On Thu, Oct 30, 2014 at 06:19:33PM +0100, Maxime Ripard wrote:
> >
> > > With AF_ALG and cryptodev, the SG is in highmem. Verified with some
> > > PageHighMem().
> > 
> > Then fix AF_ALG and cryptodev, because all of the other drivers might
> > be affected.
> 
> No it's the driver that needs to be fixed.  Of course if there
> are enough drivers it may be worthwhile adding either copying or
> a software fallback for highmem requests.

I don't understand here. Why would other drivers *not* being affected?

If the scatter list passed by AF_ALG can be in highmem, I guess it's
the case for every driver out there. Almost every kernel code I've
seen so far makes the assumption that the memory it has is mapped and
accessible.

Somehow, it's the driver's fault now, and not the part of kernel that
actually does the allocation?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/552452fb/attachment.sig>
