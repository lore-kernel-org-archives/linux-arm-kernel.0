From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 13 Jul 2010 09:39:31 +0800
Subject: [RFC, PATCH 1/2] arm: don't check MMU status in every addruart
	macro
In-Reply-To: <alpine.LFD.2.00.1007120912450.10598@xanadu.home>
References: <1278903792.387860.948595132082.1.gpush@pororo>
	<alpine.LFD.2.00.1007120912450.10598@xanadu.home>
Message-ID: <1278985171.2521.2.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> - __addruart vs addruart is rather confusing.  Normally the __xyz form 
>   is used by the higher level xyz which is opposite to what is done 
>   here.

Yes, but since __addruart is private to the one file, I decided that
this was better than renaming all of the platform addruart macros.
Either way is fine with me.

However, we may not need this with the suggested return-both-addresses
approach.

> - While at it, this should be replaced altogether by a macro that simply 
>   returns both the physical address and the virtual address for the 
>   debugging IO peripheral to use.  This would make your patch #2 much 
>   straight forward too.

OK, I'll try this out.

Cheers,


Jeremy
