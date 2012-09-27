From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 27 Sep 2012 06:57:49 +0000
Subject: [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
In-Reply-To: <20120922153313.GN4495@opensource.wolfsonmicro.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA92A1D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 21:03:14, Mark Brown wrote:
> On Fri, Aug 31, 2012 at 06:20:58PM +0530, Hebbar, Gururaja wrote:
> 
> > +config SND_DAVINCI_HAVE_SRAM
> > +	bool
> > +	default y if ARCH_DAVINCI=y
> > +	default n if ARCH_OMAP=y
> > +
> 
> I've been sitting on this mostly since it seems like a step back from
> multi-platform kernels (which is where we're trying to get to) and I've
> been trying to decide what the best approach is.  I'm thinking that we
> do want a generic API for allocating this stuff, it's a fairly generic
> feature (there's TCMs as well).  
> 
> Adding ifdefs like this does just doesn't seem good.
> 

I have no knowledge about multi-platform builds yet.

Currently this driver is shared between OMAP & DaVinci and both of them 
doesn't exist in single image build.

There was a effort done for this SRAM Consolidation [1] but it didn't progress.
Hence I took this approach as a time-being/workaround. This was we can get 
affected platforms (like AM335x) get going/working.


[1]. http://patchwork.ozlabs.org/patch/104059/

Regards, 
Gururaja
