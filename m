From: simon@fire.lp0.eu (Simon Arlott)
Date: Thu, 26 Sep 2013 12:28:33 +0100
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <5243EE06.1020200@yahoo.com.au>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <5e0b6222e8648fb0c63aa649ee70b29d11f4924f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5243EE06.1020200@yahoo.com.au>
Message-ID: <7c93a6d33e96b3eaa854bc4fbd5039594d4eca18@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, September 26, 2013 09:19, Craig McGeachie wrote:
> And if anyone is going to attempt this sort of trickery, then I'm fairly
> certain that having a well defined interrupt prioritisation scheme is
> going to be important.  Not being able to make a good prediction of
> which interrupt handler will be invoked next because you don't know what
> bit pattern the interrupt controller currently has cached doesn't seem
> good enough.

Why do you need to predict which interrupt handler will be invoked next?

> You aren't developing a framework for a bunch of cosseted application
> developers who can't even get basic resource management right.  Your
> users are device driver developers who should damn well know better than
> to hog the system.  And that is the sort of developer who would
> appreciate some more control and some slightly better guarantees from
> other code, even if the rest of the world isn't going to play ball.

Device driver developers should know better than to write drivers that
depend on such specific behaviour of the interrupt controller driver.

-- 
Simon Arlott
