From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Aug 2011 22:58:13 -0500
Subject: [PATCH 1/7] ARM: l2x0: add empty l2x0_of_init
In-Reply-To: <CAGsJ_4zS8qA-rD+NQzUo58J8pT+-4uhrCdHCKgkCJxX30KY3Ag@mail.gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
	<1314841446-11006-2-git-send-email-robherring2@gmail.com>
	<CAGsJ_4zS8qA-rD+NQzUo58J8pT+-4uhrCdHCKgkCJxX30KY3Ag@mail.gmail.com>
Message-ID: <4E5F02D5.6030508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Barry,

On 08/31/2011 10:36 PM, Barry Song wrote:
> 2011/9/1 Rob Herring <robherring2@gmail.com>:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Add empty version of l2x0_of_init for when CONFIG_CACHE_L2X0 is not selected.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> 
> Acked-by: Barry Song <21cnbao@gmail.com>
> 
Thanks.

> it seems most people use
> "
> #ifdef CONFIG_CACHE_L2X0
> ...
> l2x0 related codes
> ...
> #endif
> "
> or
> "
> obj-$(CONFIG_CACHE_L2X0) += xxx-l2x0.o
> "
> 
> to avoid l2x0 related codes compiled and linked into kernel.
> 
> but this patch provides another option. it is not bad too.
> 

The difference with existing platforms and l2x0_init is the ioremap or
static mapping and latency register setup for pl310 is outside the
function, so you still need an ifdef around all that. With l2x0_of_init,
all the setup is done inside the function, so having an empty version is
useful.

Rob
