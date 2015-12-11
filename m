From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Dec 2015 00:39:28 +0100
Subject: [GIT PULL] RealView base patches for cleanup and DT
In-Reply-To: <CACRpkdZAD-eh8k5RchnAjWyfRBiD0AN0qg_YHhwM6o001rTSQA@mail.gmail.com>
References: <CACRpkdZAD-eh8k5RchnAjWyfRBiD0AN0qg_YHhwM6o001rTSQA@mail.gmail.com>
Message-ID: <1991538.uU1eR25cvh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 14:31:11 Linus Walleij wrote:
> Hi ARM SoC maintainers,
> 
> this is the base stack of patches piled up for the RealView platforms.
> It basically adds a set of cleanups from Arnd and device tree support
> for the RealView PB11MPCore. The stack has been tested on hardware.
> 
> Both Arnd and I have outstanding patches towards the goals of
> modernizing the RealView machines, but these patches are known to
> be stable and working so let's merge this part now so it gets some
> rotation in linux-next.
> 
> I think the clk patches are missing an ACK from Mike Turquette but I don't
> think he would mind. There has been some revisions of them after feedback
> and it looks good to me.
> 
> This series requires an orthogonal series for the interrupt controller
> on the PB11MPCore, which will be merged on its own in the irqchips
> tree by Marc Zyngier.
> 
> Please pull this in!
> 

Thanks a lot for getting this ready. I see that your branch is based
on top of 4.4-rc4. Is this necessary to get it working?

I'd prefer not to have a backmerge, and the branches are currently
based on 4.4-rc3. If you don't mind, can you rebase the branch on -rc1
or -rc3?
Also, I'd prefer to merge the new .dts file as a separate patch, so these
I can take it through the next/dt branch. As far as I can see, there are
no dependencies here, you just need the file to get the machine to boot.

I'm also happy to do all the above myself next week if you prefer.

	Arnd
