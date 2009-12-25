From: mkl0301@hotmail.com (mkl lin)
Date: Fri, 25 Dec 2009 03:13:27 +0000
Subject: SMP issues on ARM11 MPCore
In-Reply-To: <4B33CAEB.3070705@googlemail.com>
References: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>,
	<4B33CAEB.3070705@googlemail.com>
Message-ID: <SNT109-W3551598CC008DC37CFB180A77E0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Could you do your tests again with
> 2.6.32
> and additionally following three patches applied
>
> 1. Global ASID allocation on SMP
> http://www.linux-arm.org/git?p=linux-2.6.git;a=commit;h=64e1c582dc57ab5278e43c4479f6ba8c967b1d1a
I have tested linux-2.6.33-rc1, which have

??????? commit 82213c680f9be0215fcdd3d6dfdc17c7089491ac
??????? Author: Catalin Marinas <catalin.marinas@arm.com>
??????? Date:?? Fri Dec 18 11:30:59 2009 +0000

??????? ??? Global ASID allocation on SMP

> 2. dma_cache_maint_contiguous should be patched as dma_cache_maint do
> http://lists.arm.linux.org.uk/lurker/message/20091210.171543.745c2f3f.en.html
I have the patch in my linux-2.6.33-rc1 port. I am using IPI patch instead of the RFO patch, for performance consideration.
However, my test have nothing to do with DMA, it should be irrelevant.

> 3. ARM: Fix a race in the vfp_notifier() function on SMPsystems
> http://lists.arm.linux.org.uk/lurker/message/20091222.153615.c803c376.en.html
linux-2.6.33-rc1 have the patch
??????? commit ac154e12c2a436830ce6745c1e9b197f7ae19afc
??????? Author: Catalin Marinas <catalin.marinas@arm.com>
??????? Date:?? Fri Dec 18 12:44:38 2009 +0000

??????? ??? Fix a race in the vfp_notifier() function on SMP systems
It seems the same issue but the patch is totally different. Is it just another solution of the same issue or what? Should I apply the patch you mentioned with? or without this one?

>> BTW, I have done a quick port to linux-2.6.33-rc1, branch master, based on commit f2d9a06. With DCache and CONFIG_LOCAL_TIMERS, I have seen case 1, which means this issue is not fixed yet.
As I've said, I have the same issue on linux-2.6.33-rc1.

Best Regards,
Mac Lin.


 		 	   		  
_________________________________________________________________
Windows Live: Keep your friends up to date with what you do online.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_1:092010
