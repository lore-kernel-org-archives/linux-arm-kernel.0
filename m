From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Oct 2012 16:54:11 +0100
Subject: [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA92A1D@DBDE01.ent.ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EA92A1D@DBDE01.ent.ti.com>
Message-ID: <20121001155410.GR4360@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 06:57:49AM +0000, Hebbar, Gururaja wrote:

> I have no knowledge about multi-platform builds yet.

> Currently this driver is shared between OMAP & DaVinci and both of them 
> doesn't exist in single image build.

...due to issues like having compile time things selecting between the
platforms.  In other words what these ifdefs would do is move us further
away from that goal rather than towards it as we should be doing.

> There was a effort done for this SRAM Consolidation [1] but it didn't progress.
> Hence I took this approach as a time-being/workaround. This was we can get 
> affected platforms (like AM335x) get going/working.

Looks like it just needs more people pushing it...
