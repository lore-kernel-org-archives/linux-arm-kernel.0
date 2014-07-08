From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 8 Jul 2014 12:41:50 -0600
Subject: [PATCH v8 6/9] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <20140708104655.GC6501@e106497-lin.cambridge.arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-7-git-send-email-Liviu.Dudau@arm.com>
 <20140708005954.GC22939@google.com>
 <20140708104655.GC6501@e106497-lin.cambridge.arm.com>
Message-ID: <CAErSpo75ovmGoeSHKJN0nckGDy-0gpn8kLPfHQ79CtcXxhPydw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 8, 2014 at 4:46 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Tue, Jul 08, 2014 at 01:59:54AM +0100, Bjorn Helgaas wrote:

>> I wonder if it would help to make a weak pci_domain_nr() function that
>> returns "bridge->domain_nr".  Then each arch could individually drop its
>> pci_domain_nr() definition as it was converted, e.g., something like this:
>>
>>   - Convert every arch pci_domain_nr() from a #define to a non-inline
>>     function
>>   - Add bridge.domain_nr, initialized from pci_domain_nr()
>>   - Add a weak generic pci_domain_nr() that returns bridge.domain_nr
>>   - Add a way to create a host bridge in a specified domain, so we can
>>     initialize bridge.domain_nr without using pci_domain_nr()
>>   - Convert each arch to use the new creation mechanism and drop its
>>     pci_domain_nr() implementation
>
> I will try to propose a patch implementing this.

I think this is more of an extra credit, cleanup sort of thing.  I
don't think it advances your primary goal of (I think) getting arm64
PCI support in.  So my advice is to not worry about unifying domain
handling until later.

Bjorn
