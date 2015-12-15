From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 15 Dec 2015 16:31:06 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <567031F2.8060102@redhat.com> (Jon Masters's message of "Tue, 15
 Dec 2015 10:29:54 -0500")
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com> <566DEDFC.909@redhat.com>
 <566F9C3D.4090306@redhat.com> <yw1xd1u8gcnk.fsf@unicorn.mansr.com>
 <567031F2.8060102@redhat.com>
Message-ID: <yw1xa8pbfzcl.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Masters <jcm@redhat.com> writes:

> On 12/15/2015 06:43 AM, M?ns Rullg?rd wrote:
>> Jon Masters <jcm@redhat.com> writes:
>
>>> But the reading of that cpio content into the new table locations is
>>> done using the kernel memcpy routine to early_ioremap'd memory (Device
>>> memory), which is architecturally sensitive to missaligned accesses.
>> 
>> As others have pointed out, your error is twofold: first using
>> early_ioremap() when early_memremap() would do, then using regular
>> memcpy() and not memcpy_fromio() on that.  Seems like your precious ACPI
>> code is to blame here.
>
> So I get that this could be changed. But I still want to understand
> whether memcpy is behaving correctly.

It is.  I already explained why it's the correct way.

-- 
M?ns Rullg?rd
