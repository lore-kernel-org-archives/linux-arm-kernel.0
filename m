From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 3 Jan 2014 01:44:10 +0100
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <20140102230832.GB9339@obsidianresearch.com>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
 <20140102194924.GA3321@obsidianresearch.com>
 <1388702192.16958.54.camel@hastur.hellion.org.uk>
 <20140102230832.GB9339@obsidianresearch.com>
Message-ID: <20140103004410.GA16928@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> .. and since the problem only shows obviously with multiplatform
> kernels that have been relocated it could be a broader, subtler issue
> than just your one board ...

It is not just this board. It is any board using an old mainline
u-boot. Any such system will not boot with a kernel after 3.1. It was
at that point that the issue was found and fixed in u-boot. My Bubba3
has a u-boot before that point...

> Jason C: What do you think about applying this [untested]?

I'm away for the weekend, so cannot test it.
 
> Or do you think the kernel should support booting with L2 on (this is
> just two instructions, but they need to be conditional on the CPU type
> :( :( )?

It would be good to at least put the fix into the impedance matcher,
so there is no need to mess with the kernel.

   Andrew
