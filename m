From: feng.wu@intel.com (Wu, Feng)
Date: Fri, 3 Jul 2015 07:00:14 +0000
Subject: [RFC 12/17] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <5596311A.3010703@redhat.com>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-13-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0025E6C89@SHSMSX104.ccr.corp.intel.com>
 <5596311A.3010703@redhat.com>
Message-ID: <E959C4978C3B6342920538CF579893F0025E70BF@SHSMSX104.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:paolo.bonzini at gmail.com] On Behalf Of Paolo
> Bonzini
> Sent: Friday, July 03, 2015 2:52 PM
> To: Wu, Feng; Eric Auger; eric.auger at st.com;
> linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
> kvm at vger.kernel.org; christoffer.dall at linaro.org; marc.zyngier at arm.com;
> alex.williamson at redhat.com; avi.kivity at gmail.com; mtosatti at redhat.com;
> joro at 8bytes.org; b.reynal at virtualopensystems.com
> Cc: linux-kernel at vger.kernel.org; patches at linaro.org
> Subject: Re: [RFC 12/17] irq: bypass: Extend skeleton for ARM forwarding
> control
> 
> 
> 
> On 03/07/2015 04:43, Wu, Feng wrote:
> >
> > struct irq_bypass_consumer {
> >        struct list_head node;
> >        void *token;
> > +      unsigned irq;	/*got from producer when registered*/
> >        void (*add_producer)(struct irq_bypass_producer *,
> >                             struct irq_bypass_consumer *);
> >        void (*del_producer)(struct irq_bypass_producer *,
> >                             struct irq_bypass_consumer *);
> > +      void (*update)(struct irq_bypass_consumer *);
> > };
> >
> > 'update' is used to update the IRTE, while irq is initialized when
> > registered, which is used to find the right IRTE.
> 
> Feel free to add "update" in your PI patches.  I am not sure if "irq"
> belongs here or in the containing struct.  You can play with both and
> submit the version that looks better to you.

Thanks for your review, Paolo. In my understanding, irq comes from
the producer side, while gsi belongs to the consumer, so we need
to get the irq from the producer somewhere. I am not sure adding
irq here is the good way, but what I need is in the 'update' function,
I have irq, gsi in hand. :)

Thanks,
Feng

> 
> Paolo
