From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Nov 2013 15:00:03 -0500
Subject: [PATCH v2] arm/arm64: kvm: Use virt_to_idmap instead of
 virt_to_phys for idmap mappings
In-Reply-To: <CAMJs5B_4UppZOTFh98R0-MoVsJ3d=qYvHys2ES=XDL+JkGfdkw@mail.gmail.com>
References: <1384887489-15290-1-git-send-email-santosh.shilimkar@ti.com>
 <CAMJs5B_4UppZOTFh98R0-MoVsJ3d=qYvHys2ES=XDL+JkGfdkw@mail.gmail.com>
Message-ID: <528BC343.1060802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 November 2013 02:50 PM, Christoffer Dall wrote:
> On 19 November 2013 10:58, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> KVM initialisation fails on architectures implementing virt_to_idmap()
>> because virt_to_phys() on such architectures won't fetch you the correct
>> idmap page.
>>
>> So update the KVM ARM code to use the virt_to_idmap() to fix the issue.
>> Since the KVM code is shared between arm and arm64, we create
>> kvm_virt_to_phys() and handle the redirection in respective headers.
> 
> sending this to the kvmarm list would be nice.
> 
I missed that accidentally. Just resent it to kvmarm list.

Regards,
Santosh
