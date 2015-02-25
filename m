From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 17:38:27 +0000
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
In-Reply-To: <CAJhHMCA74zi3qeAYTUKMsbVzxhggpzRzYKahj2WWApJ6g=hkLw@mail.gmail.com>
References: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
 <3465519.0ga9zC7F7b@wuerfel>
 <CAJhHMCCoFhi2a=qtO3EkX_Y-iy0C=STUt0ULtXMAyGEZJR_Vtw@mail.gmail.com>
 <16818946.F4B9s6bbtr@wuerfel>
 <20150225171427.GE8656@n2100.arm.linux.org.uk>
 <CAJhHMCA74zi3qeAYTUKMsbVzxhggpzRzYKahj2WWApJ6g=hkLw@mail.gmail.com>
Message-ID: <20150225173827.GH8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 12:34:35PM -0500, Pranith Kumar wrote:
> On Wed, Feb 25, 2015 at 12:14 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Actually, I think we ought to get rid of __bad_xchg() so that cases
> > like this cause a link error instead of a runtime error, just like we
> > do in other cases as well.
> >
> > That's something that goes back ages (it used to be called something
> > like invalidptr in 2.0 kernels...)
> 
> That sounds like a good idea. I will cook up a patch doing this.

I've just removed it on my build system's tree, and we'll see tomorrow
morning how it fairs.  If it spits out a lot of errors, we won't be
able to remove it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
