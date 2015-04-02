From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Apr 2015 18:31:04 +0100
Subject: [PATCH] KVM: arm64: add gic-400 compatible
In-Reply-To: <551CF409.1090707@linaro.org>
References: <20140908222144.4967.80301.stgit@joelaarch64.amd.com>
 <551CF409.1090707@linaro.org>
Message-ID: <20150402173103.GA30669@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 02, 2015 at 08:47:21AM +0100, AKASHI Takahiro wrote:
> Ping.
> This patch was acked but has never been merged?

There's a more complete patch in the kvmarm tree, queued for 4.1 [1]. It
adds both "arm,gic-400" and "arm,cortex-a7-gic".

Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/kvmarm/kvmarm.git/commit/?h=queue&id=0f37247574b3ef5b130116bbf7c0f9eb8a4c78c2

> 
> -Takahiro AKASHI
> 
> On 09/09/2014 07:21 AM, Joel Schopp wrote:
> > Add a one liner to identify the gic-400.  It's gicv2 with optional MSI extensions.
> >
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> > ---
> >   virt/kvm/arm/vgic.c |    1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> > index 73eba79..e81444e 100644
> > --- a/virt/kvm/arm/vgic.c
> > +++ b/virt/kvm/arm/vgic.c
> > @@ -1550,6 +1550,7 @@ static struct notifier_block vgic_cpu_nb = {
> >
> >   static const struct of_device_id vgic_ids[] = {
> >   	{ .compatible = "arm,cortex-a15-gic", .data = vgic_v2_probe, },
> > +	{ .compatible = "arm,gic-400", .data = vgic_v2_probe, },
> >   	{ .compatible = "arm,gic-v3", .data = vgic_v3_probe, },
> >   	{},
> >   };
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
