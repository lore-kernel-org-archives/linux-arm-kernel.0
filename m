From: yinghai@kernel.org (Yinghai Lu)
Date: Fri, 28 Apr 2017 13:51:54 -0700
Subject: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
In-Reply-To: <CAKv+Gu_n7xP-2RtF44GVzwyoMXDOeF-bR43yStwp2y+oBNs4jg@mail.gmail.com>
References: <CAKv+Gu-qRg8-YRCairppKrEfeLcW+OwVF8qZHp7vxXJA_AwPOw@mail.gmail.com>
 <20170330100524.GA22801@red-moon>
 <CAKv+Gu-ff98HrPK3f+E8soGJUXaaMxPLs2AuJ+rvXd0HWX-jXw@mail.gmail.com>
 <CAKv+Gu8YjySTDMgsrtGqEPMOtVhHc8gvTHZ4C5Ga8OTYdC9R3A@mail.gmail.com>
 <ae87ae28-f50d-095f-576e-f3fd7f96dea2@codeaurora.org>
 <CAKv+Gu8x0rQUnTUorknW-mW9LFgrxFYsXyy4LU_w9JbA-m_sjA@mail.gmail.com>
 <CAKv+Gu9Su0F9CSRe=sxomuDDH7c2szO6Z8dpqOQ=t_1Vn3JD3g@mail.gmail.com>
 <20170410165328.GA5248@red-moon>
 <CAKv+Gu-AN-OwnAJG5dt0Qg4GU8HxZBowTSA0H3LhNA3nHfrsQg@mail.gmail.com>
 <CAKv+Gu9dS4OhLbBw59yKYQmoJ8SpFexzk9yH=XfXnzn8NJ4mcg@mail.gmail.com>
 <20170423014546.GA2704@dhcp-whq-twvpn-1-vpnpool-10-159-153-149.vpn.oracle.com>
 <CAKv+Gu_n7xP-2RtF44GVzwyoMXDOeF-bR43yStwp2y+oBNs4jg@mail.gmail.com>
Message-ID: <CAE9FiQVNWC7pGjSADJVTLwEuYt90TDUhGJzrVh3VPxDz0eJqqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 6:55 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 23 April 2017 at 02:45, Yinghai Lu <yinghai@kernel.org> wrote:

>>
>> looks like those two lines are reversed. you should use:
>>                 pcibios_resource_survey_bus(bus);
>>                 pci_assign_unassigned_root_bus_resources(bus);
>>
>> please check x86 pcibios_resource_survey_bus() definition in
>>         arch/x86/pci/i386.c
>>
>> but pci_bus_claim_resources() should work too.
>>
>
> pcibios_resource_survey_bus() is actually an empty function on arm64,
> but I guess that is where logic should go that checks the state of the
> BARs before trying to claim anything?

Yes. Please copy for x86 and simplify it for arm64.

Yinghai
