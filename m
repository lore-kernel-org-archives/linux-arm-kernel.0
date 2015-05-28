From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 28 May 2015 08:58:49 -0700
Subject: [PATCH 2/3] Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA
 don't overlap the MBus bridge window"
In-Reply-To: <2099675.EoA8CYtzXr@wuerfel>
References: <1432802414-12355-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1432802414-12355-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <2099675.EoA8CYtzXr@wuerfel>
Message-ID: <20150528155849.GA14460@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 10:49:46AM +0200, Arnd Bergmann wrote:
> On Thursday 28 May 2015 10:40:13 Thomas Petazzoni wrote:
> > Fixes: 1737cac69369 ("bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window")
> > Cc: <stable@vger.kernel.org> # v4.0+
> > ---
> >  drivers/bus/mvebu-mbus.c | 105 ++++++++---------------------------------------
> >  1 file changed, 16 insertions(+), 89 deletions(-)
> 
> Hmm, the stable kernel rules say that a patch cannot exceed 100
> lines with context, so this one is technically too large.

"Technically" yes, but really, it's a guideline, if this is a revert,
this should be fine, I don't have an objection to taking it.

thanks,

greg k-h
