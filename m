From: pratikp@codeaurora.org (Pratik Patel)
Date: Wed, 12 Dec 2012 23:46:26 -0800
Subject: Coresight bus and drivers from CodeAurora
In-Reply-To: <50C8FC34.3010505@ti.com>
References: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
 <20121211213916.GB7214@pratikp-linux.qualcomm.com>
 <CACRpkdYYhAyLXJL6ns5mfFQOethihabfPpPuqz9Unq_SCJqLig@mail.gmail.com>
 <50C8FC34.3010505@ti.com>
Message-ID: <20121213074626.GB31717@pratikp-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 03:50:44PM -0600, Jon Hunter wrote:
> 
> On 12/12/2012 02:00 AM, Linus Walleij wrote:
> > On Tue, Dec 11, 2012 at 10:39 PM, Pratik Patel <pratikp@codeaurora.org> wrote:
> > 
> >> Thanks for the quick evaluation. I will be working on cleaning up
> >> the drivers for upstream submission in the coming weeks.
> > 
> > This is exactly what I like to hear :-)
> > 
> > Can you preserver the CC line from this mail on your subsequent
> > posts so the involved experts can follow the discussions?
> > 
> > It seems like keeping this new framework in drivers/ and actually refactoring
> > the old stuff in arch/arm/kernel/etm.c etc is the way forward, but doing that
> > may require some patch to support the old style of things. As the older code
> > may be stale maybe just depend on !CONFIG_OC_ETM is a way forward.
> 
> I have also been working to migrate the coresight cross-trigger
> interface (CTI) helpers from Ming Lei to a driver [1]. In the current
> implementation I have opted to make the CTI driver an AMBA device (like
> the existing ETM and ETB drivers). Therefore, I am curious if the plan
> is to migrate these other coresight devices to AMBA versus adding this
> new coresight bus?
> 
> It would be good to align on a plan here for coresight devices in general.
> 

AMBA bus is for PrimeCell devices (class 0xF) as opposed to
CoreSight devices (class 0x9).

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
