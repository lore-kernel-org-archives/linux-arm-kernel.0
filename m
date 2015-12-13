From: jcm@redhat.com (Jon Masters)
Date: Sun, 13 Dec 2015 17:15:24 -0500
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <566DEB04.2030806@redhat.com>
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com>
Message-ID: <566DEDFC.909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2015 05:02 PM, Jon Masters wrote:
> On 12/13/2015 04:36 PM, Jon Masters wrote:
> 
>> Just thinking from a parity point of view - if you can do it on x86, it should be
>> doable on ARM. But that GRUB module approach I quite like!
> 
> Sorry for top post earlier. Was on my phone. In any case, it looks like
> the "acpi" command in GRUB currently does an all-or-nothing replace of
> all of the tables, not just a named table. We need to be able to
> override e.g. just an DSDT or SSDT with a replacement test one.

I rescind that. Looking at the GRUB source clarifies things. It will
copy all host tables, then update the copied version if there are
additional tables with changes and recalculate checksums/pointers in the
XSDT etc. I seem to recall having looked at this before a couple years
ago or something and it might have grown some of the 64-bit XSDT logic
in that time. Either way, it does seem to do what I wanted. I will
followup. I'll probably still use the initrd approach for now.

Jon.
