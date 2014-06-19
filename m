From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 Jun 2014 10:21:40 +0200
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <20140618195908.GJ32514@n2100.arm.linux.org.uk>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20140618190108.GI32514@n2100.arm.linux.org.uk>
 <201406182109.59059@pali>
 <20140618195908.GJ32514@n2100.arm.linux.org.uk>
Message-ID: <20140619082140.GB4309@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2014-06-18 20:59:08, Russell King - ARM Linux wrote:
> On Wed, Jun 18, 2014 at 09:09:58PM +0200, Pali Roh?r wrote:
> > On Wednesday 18 June 2014 21:01:09 Russell King - ARM Linux 
> > wrote:
> > > On Wed, Jun 18, 2014 at 06:54:24PM +0200, Pali Roh?r wrote:
> > > > Machine name from board description is some generic name on
> > > > DT kernel. DT provides machine name property which is
> > > > specific for board, so use it instead generic one when
> > > > possible.
> > > 
> > > http://archive.arm.linux.org.uk/lurker/message/20130726.132850
> > > .53d47576.en.html
> > > 
> > > "If userspace wants to get at the DT information about a
> > > platform, we already have ways that can happen already - we
> > > export the DT stuff so that kexec's tools can get at it."
> > 
> > Userspace application does not know that kernel using DT. And 
> > also it does not want to get DT information. Only board/machine 
> > name. So existing applications stop working after migration to 
> > DT. And because legacy board boot code (without DT) is going to 
> > be removed for ARM in near future this will permanently break 
> > existing applications.
> 
> We're already breaking the userspace API through moving to DT, because
> all the device names in /sys/devices are changing.  Userspace is going
> to have to cope with change as we move towards DT.  This is just
> another aspect of moving towards DT, and one which userspace is going
> to have to deal with.
> 
> > And sometimes it is even not possible to fix userspace 
> > application if is closed source - binary only.
> 
> And why do we care about closed source?

"No regressions". Recent DT changes broke userspace we care about. Now you can either
revert DT changes, or fix the code to be compatible-enough. Second option is better, I guess.

> If we listened to this argument, then we wouldn't ever be able to
> change anything in procfs or sysfs.

If we find procfs/sysfs changes that break userspace, we revert them. Its 
that simple.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
