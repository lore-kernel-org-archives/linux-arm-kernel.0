From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 10:21:48 +0000
Subject: [PATCH 00/11] RFC: Common machine reset handling
In-Reply-To: <20131031062708.520968323@linux.com>
References: <20131031062708.520968323@linux.com>
Message-ID: <20131031102148.GW16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 07:27:08AM +0100, Domenico Andreoli wrote:
> Hi,
> 
>   I've been looking for a solution to my bcm4760 watchdog based restart
> hook when I noticed that the kernel reboot/shutdown mechanism is having
> a few unaddressed issues.
> 
> Those I identified are:
> 
>  1) context pointer often needed by the reset hook
>     (currently local static data is used for this pourpose)

I don't think that's a problem at all.

> I don't see these impressive diffstats but at least it's possible to free
> some static data along the way. Maybe there are some other desiderata that
> could be satisfied?

If that's the only benefit, then I don't think this is worth the churn,
sorry.
