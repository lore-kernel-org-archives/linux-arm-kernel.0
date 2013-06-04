From: jiada_wang@mentor.com (Jiada Wang)
Date: Tue, 4 Jun 2013 16:43:04 +0900
Subject: [PATCH v3] clk: implement clk_unregister
In-Reply-To: <857E9EDCA6C0904DB3357321AA9123EB6246497F@NA-MBX-03.mgc.mentorg.com>
References: <1370248626-3760-1-git-send-email-jiada_wang@mentor.com>
 <20130603094602.GI18614@n2100.arm.linux.org.uk>
 <857E9EDCA6C0904DB3357321AA9123EB6246497F@NA-MBX-03.mgc.mentorg.com>
Message-ID: <51AD9A88.2070706@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Wang, Jiada (ESD) wrote:
>
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, June 03, 2013 6:46 PM
> To: Wang, Jiada (ESD)
> Cc: linux-arm-kernel at lists.infradead.org; u.kleine-koenig at pengutronix.de
> Subject: Re: [PATCH v3] clk: implement clk_unregister
>
> On Mon, Jun 03, 2013 at 05:37:06PM +0900, Jiada Wang wrote:
>> Currently clk_unregister is unimplemented, it is required in case sub
>> modules want actually remove clk device registered by clk_register.
>> This patch adds the implementation of clk_unregister.
>
> So what if someone has clk_get()'d this clock but not prepared it?
> No, this is the wrong approach.  If we want to do this then clocks must be reference counted and freed when the refcount gets to zero, just like struct device etc.
>
> We have struct kref as the base structure in the kernel for dealing with these problems, please look at using it.
>
Russell

Thanks for your comment, I will look at kref.

Thanks,
jiada
