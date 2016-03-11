From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 11 Mar 2016 08:20:09 +0100
Subject: [PATCH 2/5] dmaengine: sun6i: Fix impossible settings of burst
 and bus width
In-Reply-To: <20160311064227.GR11154@localhost>
References: <cover.1457606136.git.moinejf@free.fr>
 <caa86759ff67df73c10fc3738eac5de58d582cc1.1457606136.git.moinejf@free.fr>
 <20160311064227.GR11154@localhost>
Message-ID: <20160311082009.c8b5575ca07739b30088f8d2@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Mar 2016 12:12:27 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Thu, Mar 10, 2016 at 10:27:37AM +0100, Jean-Francois Moine wrote:
> > In the commit 1f9cd915b64bb95f "dmaengine: sun6i: Fix memcpy operation",
> > the signed values returned by convert_burst() and convert_buswidth()
> > were stored in an unsigned value.
> > Then, these values were considered as errors when non null.
> > As a result, setting burst or buswidth to values different from 1 was
> > making the DMA transfers to be rejected.
> 
> A value of 0 for burst does not make sense. Frr buswidth this in undefined.
> So what are we gaining from 0 value and how is it fixing something which is
> passed as wrong argument?

The problem is not the null value, but a value different from 1:
8 as the burst or 4 as the bus width were rejected.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
