From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Mar 2010 14:20:25 -0700
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F126B9C@dbde02.ent.ti.com>
References: <20100320024827.GC11448@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F126B9C@dbde02.ent.ti.com>
Message-ID: <20100322212025.GW11448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pais, Allen <allen.pais@ti.com> [100322 00:14]:
>  
> > > > Hi all,
> > > > 
> > > > Got a zoom3 finally! This is needed to boot with DEBUG_LL 
> > + earlyprintk.
> > > 
> > > And of course it won't compile because of a missing #.
> > > Here's the working version.
> > 
> > One more time. Looks like what I posted is not enough, we
> > also need to make sure the mapping does not overlap with
> > other regions. So basically we can't use 0xfb000000 like
> > we currently have, let's use 0xf7000000 instead unless
> > somebody has better ideas.
> 
>  With this patch[DEBUG_LL + earlyprintk],
>  I still haven't been able to boot the kernel.
>  Is it working on your side.
>   
>  The commit am using is : a842b5f9ce70e1b738eabb4d719860070180ed1c

I think you will also need the 3630 serial fixes series posted
recently.

I just merged those into omap-fixes-for-linus (and master)
branch(es). Maybe give it a try with at commit
b3c7740a120c8a7775cb63b4d094466da5c01692 + this patch?

BTW, I'm still seeing mux errors on zoom3, have not yet
looked into those.

Regards,

Tony
