From: bgat@billgatliff.com (Bill Gatliff)
Date: Thu, 27 Aug 2009 07:44:32 -0500
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <24498970.196691251371216483.JavaMail.weblogic@epml12>
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
Message-ID: <4A967FB0.8090502@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jinsung Yang wrote:
> The second problem is that even though same family, the features like the memory map and internal devices (IPs) are very different.
> For example, s5p6442 and s5pc110 have different arm core, but internal devices are very similar. 
>
> Otherwise, although s5p6440 and s5p6442 are in the same family, architecture and similar names, internal devices are very different.
> It makes to be hard to integrate codes in a same platform directory.
>   

The AT91 and AVR32 SoCs have the same problem: very different cores 
(different instruction set architectures, actually), but compatible 
peripherals.  Their solution has been to embrace the platform and other 
device models heavily, which I think is the appropriate one.  I think 
this approach will work for you as well.

> So that, we are considering the following platform structure to manage our new SoCs.
>   

Wow, your naming situation is... messed up.  :)

I'm not sure I have any useful suggestion for this part.  It would have 
been nice to have a "mach-a8" and "mach-arm11" for these situations, but 
we don't and I'm not sure it wouldn't cause even more problems to create 
them.

Your suggestion is consistent with what OMAP is doing, and that approach 
seems to be working for them.  If you embrace the pluggable APIs as much 
as possible, and keep is much as you can over in drivers/, then 
hopefully the problem is more manageable.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
