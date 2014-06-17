From: panto@antoniou-consulting.com (Pantelis Antoniou)
Date: Tue, 17 Jun 2014 20:10:46 +0300
Subject: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
In-Reply-To: <20140617170531.GF3705@n2100.arm.linux.org.uk>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
 <20140617090931.GB3705@n2100.arm.linux.org.uk> <20140617125831.GI4173@beef>
 <20140617131522.GD3705@n2100.arm.linux.org.uk>
 <C3DA6AFC-2784-4A41-BC72-EF25B2B03B41@antoniou-consulting.com>
 <20140617160119.GE3705@n2100.arm.linux.org.uk>
 <317D412E-B455-4B9D-95B3-F010C68744A3@antoniou-consulting.com>
 <20140617170531.GF3705@n2100.arm.linux.org.uk>
Message-ID: <FA75104C-9D36-4EB6-BE5C-862D71E1877B@antoniou-consulting.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Jun 17, 2014, at 8:05 PM, Russell King - ARM Linux wrote:

> On Tue, Jun 17, 2014 at 07:59:21PM +0300, Pantelis Antoniou wrote:
>> That case might already work on FPGA people's trees. I know Altera for sure
>> uses overlays, and some xilinx guys popped up on past discussions.
>> Their vendor trees probably use an older revision of the patches.
>> 
>> BTW, there is nothing special about DRM/v4l2 that can't be handled by
>> a generic DT mechanism. What makes this such a big problem?
> 
> Really?
> 
> DRM is not hotpluggable in any shape or form, and David Airlie has
> indicated that he does strongly opposes moving it in that direction.
> 
> DRM follows the "card" model, where, at probe time, the hardware is
> known and never changes until the "card" is torn down.  No new
> connectors can be added once the "card" is initialised, and no
> connectors can be removed.  Any changes must be done by tearing down
> the entire card and reconstructing it (if reconstructing it with a
> reduced set of hardware is appropriate.)
> 

That is a limitation of the current DRM implementation.

I seems to be this is born out of some kind of misunderstanding about how
DT can (and does) support dynamic changes.

I admit that I haven't done much work on DRM (besides some tinkering with
Rob Clark's ti_lcdc DRM driver), but knowing what DT does have a dynamic
change notifier support, perhaps it can be made to work.

As I said, the next thing coming is transactional DT support, perhaps you
can share the DT fragment describing your use-case (before/after) and 
I'll try to accommodate in the next patch series.

Regards

-- Pantelis

> -- 
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
