From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 20:54:46 -0700
Subject: [PATCH 10/12] ARM: shmobile: r8a7740: Add CPUIdle
In-Reply-To: <51A33D83.905@linaro.org>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-11-git-send-email-horms+renesas@verge.net.au>
 <51A33D83.905@linaro.org>
Message-ID: <20130528035446.GJ13532@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 01:03:31PM +0200, Daniel Lezcano wrote:
> On 05/27/2013 10:59 AM, Simon Horman wrote:
> > From: Bastian Hecht <hechtb@gmail.com>
> > 
> > We make use of the r8a7740 Suspend To Ram code to plug together a
> > CPUIdle driver.
> > 
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> 
> Shouldn't it go through Rafael's tree ? Or does the patch contains some
> dependencies on a code only visible in the ARM tree ?

Missing S-o-b from Simon. But this patch clearly builds on the preceding
one in the series, so merging them independently might not make much
sense. Getting an ack from Rafael would be nice though.

I was going to say that it should probably go under drivers/cpuidle as
well, but that just seems silly -- there is practically no code to share
with any other platform in this small driver, AND there's not really
any subsystem-internal data exposed. So it might just make more sense
to keep it under arch/arm instead.

Likewise, looking at the kirkwood and calxeda drivers under drivers/cpuidle,
I'm wondering why we thought it was a good idea to merge them there, besides
getting caught up in the "nothing can live under arch/arm any more" frenzy.


-Olof
