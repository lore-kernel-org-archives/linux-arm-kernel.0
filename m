From: cjb@laptop.org (Chris Ball)
Date: Wed, 22 Sep 2010 13:43:09 +0100
Subject: [PATCH] mmc: failure of block read wait for long time
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B031610E332@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026F6@dbde02.ent.ti.com>
	<4C8A2C5D.2050408@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F0318B@dbde02.ent.ti.com>
	<4C971320.7050906@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03160624F6@dbde02.ent.ti.com>
	<4C974A5D.5050608@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03160626B5@dbde02.ent.ti.com>
	<4C975CFB.6070907@nokia.com>
	<20100920133703.GC30793@n2100.arm.linux.org.uk>
	<2A3DCF3DA181AD40BDE86A3150B27B6B031610E332@dbde02.ent.ti.com>
Message-ID: <20100922124309.GA15699@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 11:02:08AM +0530, Ghorai, Sukumar wrote:
> Would you please review and merge this patch [1] (attached too)?
> [1] http://comments.gmane.org/gmane.linux.kernel.mmc/2714

I've been following the thread.  I believe Adrian has NACKed this patch,
by saying "It is absolutely unacceptable to return I/O errors to the
upper layers for segments that do not have errors."

I think it's possible to merge patches to improve the situation (such
as the idea of noticing a card disappearing earlier), but your initial
patch is not the patch to do that.  You should continue to work with
Adrian -- when he's happy that a patch does not break the semantics
above, we can consider merging it.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
