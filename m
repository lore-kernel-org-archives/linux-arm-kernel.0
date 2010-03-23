From: budheej@gmail.com (Budhee Jamaich)
Date: Tue, 23 Mar 2010 14:22:15 +0200
Subject: mapping uncached memory
In-Reply-To: <20100316235422.GC13948@n2100.arm.linux.org.uk>
References: <57314e841003161617l53dc3a50la969369f0161ccdd@mail.gmail.com>
	<20100316235422.GC13948@n2100.arm.linux.org.uk>
Message-ID: <57314e841003230522k4219e31fw2b5ab610faeda767@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 1:54 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Mar 17, 2010 at 01:17:45AM +0200, Budhee Jamaich wrote:
>> these are the alternatives we currently see:
>>
>> 2. use pgprot_noncached when assigning vma->vm_page_prot in our
>> driver's mmap method
>>
>>
>> will that really work ? all memory accesses will be uncached ?
>
> Not on ARMv6 and above - it has become illegal to remap memory with
> differing type attributes.

what about using pgprot_dmacoherent in our driver to mark memory as
uncached ? will this work ?

thank you
budhee
