From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 22 Jul 2013 18:30:26 -0600
Subject: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130716234307.3d5ed229@skate>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
 <20130715162709.GA24625@dhcp-172-17-186-34.nvidia.com>
 <20130716103351.15b0fb50@skate>
 <20130716210509.GA29318@dhcp-172-17-186-34.nvidia.com>
 <20130716234307.3d5ed229@skate>
Message-ID: <CAErSpo5G=d=WsN0MnXrwYa4HgTVFre5QYj+hDeHGVXnz-Aeygg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 3:43 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Thierry,
>
> On Tue, 16 Jul 2013 14:05:10 -0700, Thierry Reding wrote:
>
>> > This is from:
>> >
>> > Subject: Re: [PATCH v2 6/8] pci: mvebu: add support for MSI
>> > Date: Tue, 18 Jun 2013 16:57:11 -0600
>>
>> Yes, I'm aware of that discussion. However we currently need to have the
>> custom root bus scan implementation anyway because pci_scan_root_bus()
>> just doesn't work on ARM. So again, since we'll have to rework the
>> driver anyway in order to use pci_scan_root_bus() once the issues have
>> been resolved, it wouldn't hurt to postpone the transition to the new
>> ARM pcibios_add_bus() support until that point.
>>
>> All I was trying to do was reduce the list of common dependencies in an
>> attempt to make merging it easier.
>
> Understood. Bjorn, since you are the one who originally requested
> the usage of pcibios_add_bus(), would you agree with the idea proposed
> by Thierry? It would remove one dependency for both the Marvell MSI
> support and Tegra PCIe support, which would help getting this code
> merged.
>
> As Thierry points out, this can easily be resolved at a later point,
> once the new hooks are merged in the ARM PCI core.

Yep, that's fine with me.
