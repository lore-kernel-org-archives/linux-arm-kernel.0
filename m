From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 30 Jan 2013 14:07:08 +0000
Subject: [PATCH v2] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
In-Reply-To: <alpine.DEB.2.00.1212200734160.7362@utopia.booyaka.com>
References: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
 <alpine.DEB.2.00.1212190210021.2446@utopia.booyaka.com>
 <1BAFE6F6C881BF42822005164F1491C33EB0C4FB@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1212200734160.7362@utopia.booyaka.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB5920F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 13:05:27, Paul Walmsley wrote:
> On Thu, 20 Dec 2012, Hebbar, Gururaja wrote:
> 
> > On Wed, Dec 19, 2012 at 07:43:50, Paul Walmsley wrote:
> > 
> > > We've got a few hwmods on OMAP44xx that don't have clkctrl_offs registers 
> > > listed in the hwmod data, and which are not marked with HWMOD_NO_IDLEST.  
> > > What's going to happen in those cases?
> > 
> > Hmm. This is a special case to me. Let me go back and do some review.
> > Will be back with some more details.
> 
> Probably what needs to happen is that those hwmods need to be marked with 
> HWMOD_NO_IDLEST, in a separate patch before yours.  As far as I can tell, 
> that's how they should have been marked initially.  Then your patch should 
> be fine.

Looking at latest kernel v3.8-rc5, there is separate cm33xx.c file which
handles module ready checking for am33xx platform. So I will update this 
patch to work on this file instead of touching omap4 related file 
(cminst44xx.c)

> 
> - Paul
> 


Regards, 
Gururaja
