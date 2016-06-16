From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Jun 2016 14:57:07 +0200
Subject: [PATCH 4/7] crypto: marvell: Moving the tdma chain out of
 mv_cesa_tdma_req
In-Reply-To: <57629562.9030908@free-electrons.com>
References: <1466018134-10779-1-git-send-email-romain.perier@free-electrons.com>
 <1466018134-10779-5-git-send-email-romain.perier@free-electrons.com>
 <20160615224249.3e1e477b@bbrezillon>
 <57629562.9030908@free-electrons.com>
Message-ID: <20160616145707.34ba532d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jun 2016 14:02:42 +0200
Romain Perier <romain.perier@free-electrons.com> wrote:

> > Now that the dma specific fields are part of the base request there's no
> > reason to keep this union.
> >
> > You can just put struct mv_cesa_req base; directly under struct
> > mv_cesa_ablkcipher_req, and move mv_cesa_ablkcipher_std_req fields in
> > mv_cesa_ablkcipher_req.  
> 
> 
> Well, I think that I might keep the changes related to mv_cesa_tdma_req 
> in this commit (+ put struct mv_cesa_req base; direct under struct 
> mv_cesa_ablkcipher_req) and move the changes related to 
> mv_cesa_ablkcipher_std_req into another commit. What do you think ?

After re-reading the code, I'm not sure the last part (moving
mv_cesa_ablkcipher_std_req fields into mv_cesa_ablkcipher_req) is a
good idea anymore.

So let's just kill the union, and move mv_cesa_ablkcipher_std_req and
mv_cesa_req base in mv_cesa_ablkcipher_req (you'll also have to remove
the base field from the mv_cesa_ablkcipher_std_req struct).

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
