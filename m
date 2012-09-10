From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Sep 2012 14:24:21 +0000
Subject: [PATCH v3 17/31] arm64: System calls handling
In-Reply-To: <20120910140148.GD27042@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <201209101351.52902.arnd@arndb.de> <20120910140148.GD27042@arm.com>
Message-ID: <201209101424.21344.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 September 2012, Catalin Marinas wrote:
> 
> On Mon, Sep 10, 2012 at 02:51:52PM +0100, Arnd Bergmann wrote:
> > On Monday 10 September 2012, Catalin Marinas wrote:
> > > Yes, I've seen these but since Al's patches are not in mainline, I don't
> > > want to add additional dependencies to the arm64 patches (currently
> > > based on 3.6-rc4). Once they get into mainline, I'll add a patch that
> > > converts arm64 to the generic functions above.
> > > 
> > > For kernel_execve(), I think I can simplify it further and not rely on
> > > Al's patches (similar to other architectures doing an SVC from kernel):
> > 
> > Hmm, I thought one of the reasons for Al to do his series was to discourage
> > people from doing syscalls from kernel space, but I may be misremembering
> > things. Al?
> 
> If that was the aim, I'm happy to change the code similar to the
> arch/arm one. But as I said I would wait until Al's patches get into
> mainline.

Ok. Another point: I wouldn't be too worried about dependencies for new
code, because it's not possible to bisect through your series anyway
(one needs all the patches before anything starts working really),
so from my point of view you could also write your code in a way that
expects Al's patches to get merged first.

	Arnd
