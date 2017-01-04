From: panand@redhat.com (Pratyush Anand)
Date: Wed, 4 Jan 2017 17:28:32 +0530
Subject: arm64: virt_to_page() does not return right page for a kernel
 image address
In-Reply-To: <20170104111119.GD8329@leverpostej>
References: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
 <20170104111119.GD8329@leverpostej>
Message-ID: <c23ad459-9dab-2085-2e0d-91ad4cedc987@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wednesday 04 January 2017 04:41 PM, Mark Rutland wrote:
> Other than the (new) crypto test and the (not yet upstream) kdump
> patches, does any code rely on virt_to_page() working for a kernel image
> address? If so, and if we cannot fix those in the short term, we may
> want to temporarily revert commit 9f2875912dac35d9 until those are fixed
> up.
>
> Regardless, I think that the kdump code should not rely on
> virt_to_page() for a kernel image (or kmap) result.

Its not the kdump code which is relying on virt_to_page() for a kernel 
image.

Its only crypto test which does that. In the first kernel (none kdump 
case) also crypto test gets a wrong kmap_atomic() address, however 
luckily there exists an entry for that address in page table and so a 
valid corresponding physical location. Therefore, it is just that we do 
not see the crash. I see still the crypto test failure print in the 1st 
kernel.
However, in crash kernel there was no valid physical address and so the 
kernel crashed.


~Pratyush
