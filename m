From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Sep 2016 13:38:09 +0100
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D69FB1.2020801@laposte.net>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net>
Message-ID: <20160912123809.GB13741@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 02:29:37PM +0200, Sebastian Frias wrote:
> My question is about submitting DT properties/nodes (describing some HW) for
> which there is no Linux driver. Like register addresses for HW blocks,
> including HW capabilities of said HW blocks, which may or may not be setup
> by Linux directly.
> 
> The idea being that since DT describes the HW and is usually shared with the
> bootloader (yet stored in the Linux kernel tree), all layers of the stack
> could use the same DT and each layer would use relevant properties. So the
> DT would describe the whole SoC even if not all HW blocks have a Linux
> driver.
> 
> 3rd party users of said SoC could then write kernel modules for such HW
> blocks using the DT description. The DT would thus become the authoritative
> source of information regarding register programming for the SoC.

I don't follow this part entirely. Why are you expecting thrid parties
to write a driver for those blocks rather than upstreaming a driver for
them?

> Currently, HW blocks for which there is no public driver (that it is
> accessed through user-mode libraries or firmware) require a separate
> HW description (be it Documentation, headers, etc.)
> 
> Since the DT describes the HW, it would make sense to expose the HW through
> DT, that would centralise the HW description.

I would generally agree that the hardware should be described in DT.
The difficulty is that without a 'real' user it's not always possible to
tell if we're describing the thing correctly.

Putting smoething together that's only sufficient to support some
out-of-tree driver with implicit assumptions that we are not aware of is
far from fantastic.

> However, after discussing over IRC, it looks like there was no guidance on
> this. Some people think submitting DT properties/nodes without a corresponding
> Linux driver is frowned upon, while others thought it was an odd limitation
> and suggested asking here.

Unfortunately, I think that the area is sufficiently vague that there
simply is no clear and general answer.

For the sake of discussion, an example of a particular block, along with
what you expect/need to describe would be helpful.

Thanks,
Mark.
