From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 26 Sep 2017 23:20:19 +0200
Subject: Unreviewed arm64 ABI change in linux-next via driver-core tree
In-Reply-To: <20170926131525.GE15480@leverpostej>
References: <20170926124536.GA11192@arm.com>
 <20170926131525.GE15480@leverpostej>
Message-ID: <20170926212019.GB28696@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 02:15:26PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Tue, Sep 26, 2017 at 01:45:37PM +0100, Will Deacon wrote:
> > Hi Greg,
> > 
> > We stumbled over a change in linux-next that has ABI implications for arm64
> > and, as far as we can tell, has not been reviewed:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/kernel?id=fb7ff3f8721b87bf078868c9a252fa0cf71a47c2
> > 
> > ("fb7ff3f8721b cpuinfo: implement sysfs nodes for arm64")
> 
> > Please can you drop this from your tree until we've had a chance to review
> > it properly? If Felix can repost it as above, then we can get the discussion
> > started because, aside from this email, we have concerns about exactly what
> > is being exposed to userspace here.
> 
> Seconded.

Now dropped.

> Experience with the existing /proc/cpuinfo shows that this needs *very*
> careful review.

Hah, yes, but with a sysfs interface, one would "hope" that you can get
it right this time around :)

> I've worked on arm64's /proc/cpuinfo, and I'd appreciate being Cc'd on
> future postings of this series. I'd also recommend that future postings
> are also Cc'd to linux-arch (and maybe linux-api) so that the interface
> is reviewed by a larger set of relevant parties.

For some reason, this set of patches never made it to lkml or the lists
multiple times.  Both you all, and the x86 developers have objected to
these changes, so they are gone for now.

Felix, please resend the series and cc: the needed people.

thanks,

greg k-h
