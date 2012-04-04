From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 4 Apr 2012 10:12:56 +0100
Subject: [BUG?] vic MULTI_IRQ_HANDLER (was [PATCH] ep93xx: Implement
 double buffering for M2M DMA channels)
In-Reply-To: <20120404091110.GB19889@mudshark.cambridge.arm.com>
References: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
 <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
 <20120402200034.GL5812@mwesterb-mobl.ger.corp.intel.com>
 <20120402214614.GK24211@n2100.arm.linux.org.uk>
 <20120403170812.GR17741@mudshark.cambridge.arm.com>
 <ADE657CA350FB648AAC2C43247A983F0020698409E00@AUSP01VMBX24.collaborationhost.net>
 <20120404091110.GB19889@mudshark.cambridge.arm.com>
Message-ID: <CACb=_tTaW7O+9AwaroRYvhw-gcKEO_GrufzmDs76P=YBmZ+S1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2012 10:11, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Apr 03, 2012 at 06:46:40PM +0100, H Hartley Sweeten wrote:
>> On Tuesday, April 03, 2012 10:08 AM, Will Deacon wrote:
>> > diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
>> > index dcb004a..cb6b49a 100644
>> > --- a/arch/arm/common/vic.c
>> > +++ b/arch/arm/common/vic.c
>> > @@ -441,11 +441,9 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
>> > ? ? ? ? u32 stat, irq;
>> > ? ? ? ? int handled = 0;
>> >
>> > - ? ? ? stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
>> > - ? ? ? while (stat) {
>> > + ? ? ? while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
>> > ? ? ? ? ? ? ? ? irq = ffs(stat) - 1;
>> > ? ? ? ? ? ? ? ? handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
>> > - ? ? ? ? ? ? ? stat &= ~(1 << irq);
>> > ? ? ? ? ? ? ? ? handled = 1;
>> > ? ? ? ? }
>>
>> This should be posted as a proper patch with your Signed-off-by.
>
> If Jamie's happy with the change, I'll repost.

Sure, lgtm.

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
