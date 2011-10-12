From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 16:19:10 -0700
Subject: [PATCH v4 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <CACxGe6tf0Ly8AC-6xUeoMrVj3y0KHkrcgj87SerAaCAnNhfNqA@mail.gmail.com>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
	<1318371375-4083-3-git-send-email-swarren@nvidia.com>
	<20111012224131.GD25128@quad.lixom.net>
	<CACxGe6tf0Ly8AC-6xUeoMrVj3y0KHkrcgj87SerAaCAnNhfNqA@mail.gmail.com>
Message-ID: <20111012231910.GA13960@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 05:03:24PM -0600, Grant Likely wrote:
> On Wed, Oct 12, 2011 at 4:41 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Tue, Oct 11, 2011 at 04:16:14PM -0600, Stephen Warren wrote:
> >> v3: Make regs variable static. Remove empty init of tegra_gpio_banks.
> >>
> >> v2: Retrieve IRQ and memory addresses from resources instead of hard-
> >> coding them. Add back initialization of tegra_gpio_chip.of_node.
> >
> > In the future, please move the revision log to below the ---, and just have
> > the main patch description above, since that is what goes into the git repo.
> 
> No!  Keep it above the line so it shows up in the Linux commit log.
> It makes it easier to know which version of a patch actually got
> committed.  :-)

Alright, I'm convinced.

Maybe it was the fact that the patch description was 100% revision log that
made me notice it this time. :)

> >> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> >
> > Otherwise, patch looks good. Due to dependencies between this, the rest
> > of this patch series and the pinmux changes, I'll hold off on it until
> > the dependencies land (i.e. target it for 3.3). We're cutting it very close
> > to the merge window as it is, I'll start for-3.3 branches shortly.
> 
> Actually, see if you can get it in via the same tree as the pinmux
> changes.  Dependencies is not a reason to hold off from getting it
> into linux-next.

Ok, the fixup is minimal, should be trivial to spot at git merge time.

Stephen, do you want to respin yourself or should I do the __devinit
change when I apply?


-Olof
