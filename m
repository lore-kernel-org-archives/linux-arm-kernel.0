From: adam.cottrel@veea.com (Adam Cottrel)
Date: Mon, 15 Oct 2018 15:24:55 +0000
Subject: DMA remote memcpy requests
In-Reply-To: <20181015150912.GA8789@hc>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012090937.GA12289@arm.com>
 <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
 <b56bf98f-5055-fb85-7807-e45d495369f3@arm.com>
 <DM6PR04MB405918E803AF4FCC34B12083F2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181015150912.GA8789@hc>
Message-ID: <DM6PR04MB4059991247828ADBD6133D2FF2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jan,

> from your description this sound like it:
> - only happens under memory pressure
> - only happens when you combine atheros DMA with something else (or
> does
>   the MMC stress test trigger any faults on its own?)
> 
> With that I would look through all the allocations in the atheros driver and
> especially look for any missing error handling. But that's just my 2 cents,
> maybe Robin or Will can give better advise here...

That is good advice.

>From what I can see, there are checks made on every alloc, however, it is possible that the failure is silently handled.

For example, memory is allocated with __GFP_IGNORE and the error flag is lost because the called returned void...

I have put in a lot of debug code to look for this type of fault - it is possible that I have missed the exact point of failure...

Is there some kind of queue of outstanding remote DMA requests? And if so, is it possible that the request queue can overflow in some way?

Best,
Adam
