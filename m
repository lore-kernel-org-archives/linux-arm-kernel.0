From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Dec 2012 07:35:27 +0000 (UTC)
Subject: [PATCH v2] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB0C4FB@DBDE01.ent.ti.com>
References: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
 <alpine.DEB.2.00.1212190210021.2446@utopia.booyaka.com>
 <1BAFE6F6C881BF42822005164F1491C33EB0C4FB@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1212200734160.7362@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Dec 2012, Hebbar, Gururaja wrote:

> On Wed, Dec 19, 2012 at 07:43:50, Paul Walmsley wrote:
> 
> > We've got a few hwmods on OMAP44xx that don't have clkctrl_offs registers 
> > listed in the hwmod data, and which are not marked with HWMOD_NO_IDLEST.  
> > What's going to happen in those cases?
> 
> Hmm. This is a special case to me. Let me go back and do some review.
> Will be back with some more details.

Probably what needs to happen is that those hwmods need to be marked with 
HWMOD_NO_IDLEST, in a separate patch before yours.  As far as I can tell, 
that's how they should have been marked initially.  Then your patch should 
be fine.

- Paul
