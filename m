From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Mar 2013 19:47:43 +0100
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <5155C9C6.4070702@wwwdotorg.org>
References: <5137C404.9060902@wwwdotorg.org>
 <20130307144506.GB7344@amd.pavel.ucw.cz>
 <5138FDAE.8060202@wwwdotorg.org>
 <20130311050546.GA21863@quad.lixom.net>
 <CACxGe6vkC7fjzf1-+K8O81+w=jQ63PvuTEhSPyitEBA9XiKYnw@mail.gmail.com>
 <20130328092916.GA11187@amd.pavel.ucw.cz>
 <51545870.4010209@wwwdotorg.org>
 <20130328193323.GA25166@amd.pavel.ucw.cz>
 <20130328195456.GA22527@quad.lixom.net>
 <5155C9C6.4070702@wwwdotorg.org>
Message-ID: <20130329184743.GA3409@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> Have old kernel running, dtbs building. Apply a patch. It starts
> >> behaving weird. You do make clean... but you still get old dtbs.
> >>
> >> (It would be nice if make socfpga_cyclone5.dtb would magically remove
> >> all the dtbs from old location; make dtbs does that if I understand
> >> stuff correctly).
> > 
> > 
> > This takes care of the "make dtbs" case (or just "make" case), but not
> > when you build a specific target.
> 
> I guess to really solve this, we need the following changes:
> 
> In the all kernels:
> 
> For both arch/*/boot and arch/*/boot/dts: clean removes *.dtb
...
> make dtbs and make foo.dtb both rm dts/*.dtb
> 
> Is that too much to retrofit into all the stable kernels?

Well... since we need stable, anyway... what about:

Revert to good old location, fix 3.8 via stable tree, add "clean
removes *.dtb" to new kernels, so that people are not confused?

Yes, that means we keep old location, but arguably dtbs belong there,
and it is compatible with powerpc.... and we will not have to do so
much stable updates.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
