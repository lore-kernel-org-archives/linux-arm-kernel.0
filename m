From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Feb 2015 19:07:20 +0000
Subject: [PATCH] kvmtool: don't use PCI config space IRQ line field
In-Reply-To: <CAFEAcA_zKisc6YOm_4vqpOWCkG5aeyfha1u_-8=DeT6CCRJUwQ@mail.gmail.com>
References: <4324891.mqG6Yyfi6J@wuerfel>
 <1423064390-15269-1-git-send-email-andre.przywara@arm.com>
 <20150206185527.GC24099@arm.com>
 <CAFEAcA_zKisc6YOm_4vqpOWCkG5aeyfha1u_-8=DeT6CCRJUwQ@mail.gmail.com>
Message-ID: <20150206190719.GG24099@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 07:02:25PM +0000, Peter Maydell wrote:
> On 6 February 2015 at 18:55, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Feb 04, 2015 at 03:39:50PM +0000, Andre Przywara wrote:
> >> In PCI config space there is an interrupt line field (offset 0x3f),
> >> which is used to initially communicate the IRQ line number from
> >> firmware to the OS. _Hardware_ should never use this information,
> >> as the OS is free to write any information in there.
> >
> > Is this true even with probe-only? I appreciate that this isn't a BAR,
> > but it still feels odd for Linux to write this in that case.
> 
> The hardware (model) shouldn't be doing anything with the value
> in this register anyway, so I think this change to kvmtool is
> correct regardless of Linux's behaviour.

Well, kvmtool is also pretending to be firmware in this case, which is why
it passes things like probe-only and PSCI nodes.

Will
