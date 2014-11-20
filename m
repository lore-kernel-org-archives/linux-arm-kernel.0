From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 20 Nov 2014 15:34:53 +0100
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <912A29987EAE174BA6CF187D7CDFA9CE26F69163@DLEE08.ent.ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com>
 <912A29987EAE174BA6CF187D7CDFA9CE26F69163@DLEE08.ent.ti.com>
Message-ID: <20141120143453.GA5809@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brad,

What you wrote is just the kind of thing one would like to see in the
cover letter or change log...

On Thu, Nov 20, 2014 at 02:23:30PM +0000, Griffis, Brad wrote:
> In that thread the user was registering multiple press events for a single press.  By increasing the udelay to 1.5ms they were able to solve the problem.  Of course, having a 1.5ms delay in your ISR is a really bad thing to do...

I fully support removing the aweful ISR delay, as long as the result
works!
 
> I have another customer that was experiencing the same issue of registering multiple press events, and sure enough the 1.5ms delay "fixed" their problem too.  The patches allowed them to remove that gigantic delay from the ISR because that software delay has now become a hardware delay via CHARGECONFIG.  That customer is the one that needed 0xB000 which is MUCH larger than the value of 0x400 that was working fine for me on the EVM.

It would be really nice for TI to explain to board designers how to
calculate the proper value.

Thanks,
Richard
