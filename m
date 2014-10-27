From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 27 Oct 2014 17:48:17 -0500
Subject: [PATCHv2 0/4] Add Altera peripheral memories to EDAC framework
In-Reply-To: <20141027215908.GC4741@pd.tnic>
References: <1413578029-13205-1-git-send-email-tthayer@opensource.altera.com>
 <544E93F0.3030409@opensource.altera.com> <20141027204307.GB4741@pd.tnic>
 <544EBA84.7080109@opensource.altera.com> <20141027215908.GC4741@pd.tnic>
Message-ID: <544ECBB1.2040600@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/27/2014 04:59 PM, Borislav Petkov wrote:
> On Mon, Oct 27, 2014 at 04:35:00PM -0500, Thor Thayer wrote:
>> Should I move the EDAC Device probe and error handling from
>> altera_edac_mgr.c to altera_edac.c? Can I mix the MC and Device models
>> in the same file?
> Right, for basic practical reasons, I'd like to keep all functionality
> pertaining to one hw flavour in one compilation unit/one driver. We can
> always split them later if a compelling reason emerges.
>
> Thanks.
>
OK. I will make the changes.

Would the L2 cache and OCRAM specific functions also be in 
altera_edac.c? Each of these EDAC pieces is independent and can be 
compiled in without the others. I've read that the use of #ifdef's is 
discouraged and having separate files in the Makefile solves that.

Thanks for the clarification.

Thor
