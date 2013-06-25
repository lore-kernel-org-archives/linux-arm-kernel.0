From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Jun 2013 11:55:52 +0200
Subject: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific
 functions
In-Reply-To: <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130620185707.GA8888@mithrandir>
 <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
Message-ID: <20130625115552.7ebdad17@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Mon, 24 Jun 2013 19:52:45 -0600, Bjorn Helgaas wrote:

> I agree; the whole point of __weak is to provide a "default"
> implementation, so I hope you can just remove any empty default_*()
> functions and fold the others into the arch_*() functions directly.
> 
> If there actually are callbacks from arch-specific strong functions
> back to the stuff in the default_*() functions, that suggests that we
> should refactor and rename that bit of functionality.

There is one such case, as highlighted in the commit log of this patch:

"""
This is needed because the x86 Xen implementation of
teardown_msi_irqs() needs to do some work, and then call the default
implementation of this hook.
"""

Any suggestion on how to solve this particular case?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
