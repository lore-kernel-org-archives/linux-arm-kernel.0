From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 28 Mar 2013 20:33:23 +0100
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <51545870.4010209@wwwdotorg.org>
References: <20130306193332.GA6022@amd.pavel.ucw.cz>
 <5137C404.9060902@wwwdotorg.org>
 <20130307144506.GB7344@amd.pavel.ucw.cz>
 <5138FDAE.8060202@wwwdotorg.org>
 <20130311050546.GA21863@quad.lixom.net>
 <CACxGe6vkC7fjzf1-+K8O81+w=jQ63PvuTEhSPyitEBA9XiKYnw@mail.gmail.com>
 <20130328092916.GA11187@amd.pavel.ucw.cz>
 <51545870.4010209@wwwdotorg.org>
Message-ID: <20130328193323.GA25166@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2013-03-28 08:49:20, Stephen Warren wrote:
> On 03/28/2013 03:29 AM, Pavel Machek wrote:
> ...
> > There's change that makes it pretty much impossible to build dtbs
> > reliably between different kernel versions, because it leaves old dtbs
> > around, and they survive even make clean.
> 
> One question here: Presumably the dtbs don't survive "make clean" if you
> run that right after building the dtbs, but only if you check out a new
> kernel version before running clean? Or is that not the case?

That was the case I seen, yes.

Have old kernel running, dtbs building. Apply a patch. It starts
behaving weird. You do make clean... but you still get old dtbs.

(It would be nice if make socfpga_cyclone5.dtb would magically remove
all the dtbs from old location; make dtbs does that if I understand
stuff correctly).

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
