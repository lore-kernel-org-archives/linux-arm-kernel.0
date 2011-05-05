From: tim.bird@am.sony.com (Tim Bird)
Date: Thu, 5 May 2011 11:19:45 -0700
Subject: [RFC PATCH] arm: drop Execute-In-Place
In-Reply-To: <alpine.LFD.2.00.1105051413080.24613@xanadu.home>
References: <1304607121-13612-1-git-send-email-plagnioj@jcrosoft.com>
	<4DC2E5AA.5010604@am.sony.com>
	<alpine.LFD.2.00.1105051413080.24613@xanadu.home>
Message-ID: <4DC2EA41.7030809@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2011 11:17 AM, Nicolas Pitre wrote:
> On Thu, 5 May 2011, Tim Bird wrote:
> 
>> On 05/05/2011 07:52 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> nearly no-one use it, only amop1, pxa and sa1100 implement it
>>
>> Sony uses this - a lot.  Principally we're using this on a NEC
>> naviengine part, which is ARM11MPCore based, support for which
>> is (sadly) out of tree.
>>
>> I'd like to see MORE support for XIP in the kernel, not less.
> 
> OK.  If done properly, there shouldn't be any need to drop XIP support.  
> However, given that XIP is already a specialized configuration that is 
> handled by hardware experts, in the future you might have to provide at 
> kernel configuration time the actual physical address of your RAM as it 
> is currently done for the ROM address where the kernel image is located.

That wouldn't be a problem.
The tools to set this up (make images) already have to hardcode
the physical addresses at build time, so adding it to the kernel
config is no big deal.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
