From: JBeulich@suse.com (Jan Beulich)
Date: Thu, 10 Sep 2015 07:08:50 -0600
Subject: [Xen-devel] [PATCH] efi/libstub/fdt: Standardize the names
 of EFI stub parameters
In-Reply-To: <1441889905.24450.382.camel@citrix.com>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
 <20150910095208.GA29293@leverpostej>
 <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
 <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <1441889905.24450.382.camel@citrix.com>
Message-ID: <55F19D0202000078000A1B54@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 10.09.15 at 14:58, <ian.campbell@citrix.com> wrote:
> On Thu, 2015-09-10 at 13:15 +0100, Mark Rutland wrote:
> 
>> > In any case this should be separate from the shim ABI discussion.
>> 
>> I disagree; I think this is very much relevant to the ABI discussion.
>> That's not to say that I insist on a particular approach, but I think
>> that they need to be considered together.
> 
> Taking a step back, the reason for using the EFI stub parameters is only
> (AFAIK) in order to be able to locate the ACPI RDSP (the root table
> pointer), which as it happens is normally passed via one of the EFI
> firmware tables.
> 
> If there was a way to achieve that goal (i.e. another way to find the RSDP)
> without opening the can of UEFI worms then we could consider that opiton
> too.
> 
> a way != the legacy x86 thing of scanning low memory of the signature, of
> course.

But even x86 doesn't do that (other than as a fallback) on EFI. The
configuration table is available to Dom0 (via XENPF_firmware_info:
XEN_FW_EFI_INFO:XEN_FW_EFI_CONFIG_TABLE).

Jan
