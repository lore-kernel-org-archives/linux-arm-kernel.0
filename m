From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Tue, 26 Nov 2013 18:33:44 +0000
Subject: ACPI
In-Reply-To: <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
 <20131125154110.GB3243@srcf.ucam.org>
 <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
 <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
Message-ID: <20131126183344.GA16074@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 12:55:10PM +0000, Grant Likely wrote:
> On Tue, Nov 26, 2013 at 12:43 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> > I have a feeling we should not recommend ARM implementers
> > to go and do things like this.
> 
> ACPI5 defines a binding for serial busses (i2c & spi) which allows
> real device drivers to drive the bus and allows ACPI and the kernel to
> share the bus safely. Using that binding means some i2c devices can be
> 'owned' by ACPI and others owned by the kernel.

Right, we shouldn't see a problem in this specific case. But it does 
leave a wider philosophical concern - there are still components that 
can't be exposed to the OS via ACPI in standardised ways, and the 
traditional way of dealing with that on x86 is to just add the 
functionality via ASL. It seems that we have three basic options:

1) Encourage vendors to add functionality to their DSDTs
2) Encourage vendors to use existing kernel functionality, exposing 
information via either DT-in-ACPI or some other custom method
3) Encourage vendors to continue using DT until this functionality is 
standardised

Being consistent about our recommendations here would probably be 
helpful, but it seems like we don't have any kind of thought out story 
yet. That seems like a problem.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
