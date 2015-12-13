From: jcm@redhat.com (Jon Masters)
Date: Sun, 13 Dec 2015 17:19:02 -0500
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <CAGCh1+nb-H-B28crGuTPUKXZrBN_XDn7fNHf4q8LZZOgyhtDmQ@mail.gmail.com>
References: <566D3090.9090509@redhat.com>	<20151213165942.GN25034@bivouac.eciton.net>	<23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>	<566DEB04.2030806@redhat.com>
 <CAGCh1+nb-H-B28crGuTPUKXZrBN_XDn7fNHf4q8LZZOgyhtDmQ@mail.gmail.com>
Message-ID: <566DEED6.3010704@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2015 05:15 PM, G Gregory wrote:
> On 13 December 2015 at 22:02, Jon Masters <jcm@redhat.com> wrote:
>> On 12/13/2015 04:36 PM, Jon Masters wrote:
>>
>>> Just thinking from a parity point of view - if you can do it on x86, it should be
>>> doable on ARM. But that GRUB module approach I quite like!
>>
>> Sorry for top post earlier. Was on my phone. In any case, it looks like
>> the "acpi" command in GRUB currently does an all-or-nothing replace of
>> all of the tables, not just a named table. We need to be able to
>> override e.g. just an DSDT or SSDT with a replacement test one.
>>
> I think thats just clumsily worded documentation. The code certainly
> looks like you can replace them individually.

Yea, it does. It's unfortunate that the code is more "obvious" than the
docs, but hardly the first time ;)

> I think its trying to say in the case RSDP,XSDT,RSDT are in ROM it
> will create new ones to point to the new tables you've just imported.

Yea. I think it actually ends up creating new tables in any case, then
copies over the bits that change. It'll actually need to do that anyway
because it'll want to update the pointers to new tables. I'll try it.
But I also want to see the initrd approach working in the not too
distant future - everything someone can do on an x86 system should
translate 1:1 in terms of experience. It'll help with bringup of newer
platforms such as the one I have that needs some NUMA related tweaks.

> I had planned to try it this week anyway.

Great :)

Jon.
