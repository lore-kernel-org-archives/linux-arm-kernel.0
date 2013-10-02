From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Wed, 02 Oct 2013 22:18:52 +1300
Subject: [RFC PATCH 1/3] Enable BCM2835 mailbox support
In-Reply-To: <524B8A04.1020006@wwwdotorg.org>
References: <5232F7B7.4070206@yahoo.com.au> <524B8A04.1020006@wwwdotorg.org>
Message-ID: <524BE4FC.8030306@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 03:50 PM, Stephen Warren wrote:
> On 09/13/2013 05:32 AM, Craig McGeachie wrote:
>> Cherry-picked selection of commits by Lubomir Rintel [1], Suman Anna and
>> Jassi Brar [2] on which to base the implementation.
>>
>> Signed-off-by: Suman Ana <s-anna@ti.com>
>> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>>
>> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
>> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
>
> This needs a proper patch description. It should describe what the
> mailbox HW is, what services it provides, etc.
>
> There shouldn't be any text after the tag paragraph (i.e. the s-o-b
> lines) and the --- separator.
>
> Are you able to generate patches using "git format-patch". That would
> included diffstat in the patch summary, which can be useful.

I can do all that.  I'm rather new to all of this, and didn't get git 
format-patch and git send-email sorted out until after this.  You really 
don't want to know what I did to get this sent.

> I'd prefer to see patch 1 and 2 squashed together, since the new mailbox
> driver should just be implemented in one shot, rather than added with
> one implementation, then reworked to be different in a separate patch.
>
> That said, the patches need to be split up based on subsystem divisions.
> The squashed patch 1 and 2, and the separate patch 3, should be split into:
>
> a) A patch that adds the driver. This would touch just
> drivers/mailbox/... (or drivers/thermal/...) and
> Documentation/devicetree/bindings/...
>
> b) A patch that adds the necessary entries to *.dts/*.dtsi
>
> c) A patch that enables any new entries in bcm2835_defconfig.
>
> In my initial round of review, I'll only discuss the DT bindings, and
> only in response to patch 2 where they're complete rather than here.
> Once the bindings are finalized and the driver adjusted to implement the
> final bindings, then I'll look at the driver code.

I'll look at restructuring the patches.  Are you really sure about 
drivers/mailbox/* and drivers/thermal/* as one patch?

The serious concern that I have is that Suman Anna and Jassi Brar are 
still working on the core mailbox subsystem.  I've just captured their 
work to present a working patch that will build and show the mailbox 
working.  That is why I marked the series as RFC.  I'm not happy about 
submitting someone else's work that I know is still evolving. 
Especially when I know that there are a couple of fixes that Jassi has 
made but not published yet.

For all that, I want mailbox support for the BCM2835 as soon as 
possible.  I see its lack as a serious blocker.  The video driver needs 
it to get the videocore to map an agreed chunk of memory for a 
framebuffer.  The DMA controller could use it to find which DMA channels 
are available for use by the ARM core.  Power management of whole 
devices uses it (DMA can turn individual channels on and off but that's 
with iomem register).  There may be more, but that's all I've 
researched.  Anything I can do to hasten the general availability of 
mailbox support ... well, anything that doesn't involve stepping on toes.

> Note that all new DT bindings should be CC'd to the DT bindings
> maintainers; see the following in MAINTAINERS:
>
> OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> M:      Rob Herring <rob.herring@calxeda.com>
> M:      Pawel Moll <pawel.moll@arm.com>
> M:      Mark Rutland <mark.rutland@arm.com>
> M:      Stephen Warren <swarren@wwwdotorg.org>
> M:      Ian Campbell <ijc+devicetree@hellion.org.uk>
> L:      devicetree at vger.kernel.org
> S:      Maintained
> F:      Documentation/devicetree/
> F:      arch/*/boot/dts/
> F:      include/dt-bindings/

Do you want me to CC this interim discussion as well, or wait until 
there is a more accpetable patch put together.

>>   +		mailbox {
>
> Patch corruption? + is indented!

As I said.  Poor tool use.

Cheers,
Craig.
