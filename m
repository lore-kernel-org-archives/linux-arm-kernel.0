From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 9 Jun 2016 15:39:35 +0200
Subject: [PATCH] ARM: orion: remove unreferenced board-d2net.c
In-Reply-To: <20160609133116.GH30205@lunn.ch>
References: <1465466656-30002-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160609133116.GH30205@lunn.ch>
Message-ID: <20160609153935.44323b8e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 9 Jun 2016 15:31:16 +0200, Andrew Lunn wrote:
> On Thu, Jun 09, 2016 at 11:04:16AM +0100, Ben Dooks wrote:
> > Either this has been mis-converted (and needs to be fixed) or
> > is no longer referenced and can be safely removed.  
> 
> Hi Thomas
> 
> You added this code, which Ben is removing. It does look like you
> forgot to call d2net_init() from orion5x_dt_init().
> 
> Please could you look at this.

You are correct: d2net_init() should be called from orion5x_dt_init(),
or called through some initcall mechanism.

That being said, this has been broken more than 2 years ago, and nobody
noticed. Doesn't this mean that we could get rid of the support for
this board entirely? :)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
