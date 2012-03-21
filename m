From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Mar 2012 12:36:37 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <4F69BC35.4010400@st.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203151339.36173.arnd@arndb.de> <4F69BC35.4010400@st.com>
Message-ID: <201203211236.37891.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 March 2012, Viresh Kumar wrote:
> > 
> > What's wrong with one vic_dt_init_irq() function and an array with two entries?
> 
> Hey Arnd,
> 
> Actually i was doing 3xx DT porting and again came to this thing. I believe what
> you suggested should be fine too as the actual vic model/name is going to be
> passed from .dts file.
> 
> If this is acceptable to you, i will add patch for both vic & gic in my
> patchset.

Ok, sounds good.

Let's make sure we're on the same page with the process though. I hope
you're aware that I took Stefan's spear6xx v5 patch. I just now saw that
you were not on Cc on the submission of the patch nor on my reply, but you
had given your Ack on the patch. Just let me know how you want to handle
these things in the future -- the normal way would be to always let you
forward the patches to me, rather than having them applied to arm-soc
directly.

Regarding the spear3xx patches, I'm looking forward to your patches.
I think spear is simple and clean enough that it can serve as an example
for others doing DT conversion. Do you also plan to unify 3xx and 6xx?
I think there is hardly anything left in mach-spear6xx that justifies
having a separate platform, especially since with the DT conversion done,
we can actually remove most of the header file contents as well.

	Arnd
