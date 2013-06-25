From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 25 Jun 2013 10:20:33 -0600
Subject: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific
 functions
In-Reply-To: <20130625115552.7ebdad17@skate>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130620185707.GA8888@mithrandir>
 <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
 <20130625115552.7ebdad17@skate>
Message-ID: <CAErSpo67ogc6R=vk+dt0Y6OFvwtLTL57tHx1u1zTkqY9g4N_1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 3:55 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Mon, 24 Jun 2013 19:52:45 -0600, Bjorn Helgaas wrote:
>
>> I agree; the whole point of __weak is to provide a "default"
>> implementation, so I hope you can just remove any empty default_*()
>> functions and fold the others into the arch_*() functions directly.
>>
>> If there actually are callbacks from arch-specific strong functions
>> back to the stuff in the default_*() functions, that suggests that we
>> should refactor and rename that bit of functionality.
>
> There is one such case, as highlighted in the commit log of this patch:
>
> """
> This is needed because the x86 Xen implementation of
> teardown_msi_irqs() needs to do some work, and then call the default
> implementation of this hook.
> """
>
> Any suggestion on how to solve this particular case?

Nope.  Just leave it as-is for that case and consolidate what you can.

Bjorn
