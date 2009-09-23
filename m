From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 24 Sep 2009 07:30:40 +0800
Subject: [PATCH/RFC] Runtime PM: ARM: subarch-specific extensions of
	pdev_archdata
In-Reply-To: <4ABAAF1D.6090907@deeprootsystems.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
Message-ID: <f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 7:28 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mikael Pettersson wrote:
>>
>> Eric Miao writes:
>> ?> On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>> ?> <khilman@deeprootsystems.com> wrote:
>> ?> > On ARM platforms, power management can be very platform specific.
>> ?> > This patch allows ARM subarches to extend the platform_device
>> ?> > pdev_archdata for each subarch by creating a new struct pdev_machdata
>> ?> > and allowing each subarch to customize it as needed.
>> ?> >
>> ?> > As a starting point, each subarch's <mach/device.h> creates an empty
>> ?> > struct pdev_machdata.
>> ?> >
>> ?> ?> Shouldn't that pdev_archdata and pdev_machdata be pointer or
>> something
>> ?> so that multiple platform_device can share something in common?
>>
>> Forcing it to be a pointer has allocation and lifetime implications.
>> Making it a struct allows the subarch to duplicate or share
>> (via a private pointer) data as it sees fit.
>
> Yes, the allocation/lifetime issues were why a struct was chosen.
>

Mmm... this makes sense to me. I'm ok with this patch - just wondering
for the moment what to put for the pxa architecture - I'll see what davinci
will do first, of course :)
