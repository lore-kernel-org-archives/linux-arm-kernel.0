From: yinghai@kernel.org (Yinghai Lu)
Date: Wed, 13 Feb 2013 13:02:51 -0800
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <20130213003224.GA32535@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302121902.14276.arnd@arndb.de>
 <20130212193848.GE1471@obsidianresearch.com>
 <201302122305.28467.arnd@arndb.de>
 <20130213003224.GA32535@obsidianresearch.com>
Message-ID: <CAE9FiQWPhZDQ47Wp+7LkG4H2ZvKFKcAsYZ2Xfb8E4ze7=bpN=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 4:32 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Feb 12, 2013 at 11:05:28PM +0000, Arnd Bergmann wrote:
>>
>> Ah, so you only allow hotplugging into the root ports, but not behind
>> additional bridges that have active devices on them, right?
>
>> I guess that is a common limitation for PCIe hotplugging.
>
> In all the cases I've worked with, it has been a root port hot plug,
> but I could imagine something like ExpressCard requiring a second
> bridge.
>
> The standard answer is to leave appropriate gaps. My *guess* on this
> matter is that on x86 the gaps are left, as appropriate, by the boot
> firmware. Eg an ExpressCard slot will always have a window assigned to
> its bridge and Linux would typically not reassign it (or similar).

Yes, x86 BIOS will leave some pad number for every pcie root port.

Also with patches in
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
 for-pci-busn-alloc

could realloc bus range to get big bus number.

Thanks

Yinghai
