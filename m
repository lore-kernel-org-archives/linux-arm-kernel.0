From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 7 Oct 2010 12:13:10 -0500
Subject: [RFC] tidspbridge: use a parameter to allocate shared memory
In-Reply-To: <201010071601.04597.laurent.pinchart@ideasonboard.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
	<201010070940.14208.laurent.pinchart@ideasonboard.com>
	<20101007083242.GB14554@n2100.arm.linux.org.uk>
	<201010071601.04597.laurent.pinchart@ideasonboard.com>
Message-ID: <4CADFFA6.50202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/7/2010 9:01 AM, Laurent Pinchart wrote:
> On Thursday 07 October 2010 10:32:42 Russell King - ARM Linux wrote:
>>
>> ARMv6 and above don't like having multiple mappings with different
>> memory type/shareability/cache attributes.  It's architecturally
>> forbidden.
>>
>> So if you want non-cacheable memory and you want to be architecturally
>> compliant, you have to exclude it from the kernel's direct-mapped
>> memory mapping.
>
> That's why Omar's patch uses 'mem=' to exclude system memory from the kernel
> mappings. That's not ideal though, as that memory will be wasted forever,
> hence my comments regarding whether a non-cacheable mapping was really
> required.

it is not ideal to waste that memory, but strictly speaking old bootmem 
does the same, as no one will be touching that memory. i.e. you compile 
bridge as a module but you never insmod it, the reserved bootmem space 
is there for bridge anyway; same for bootargs tweaking, if you need 
dspbridge and are going to use it then you set aside some memory for it.

What might be a pain for end-user, is to have drivers that need to do 
tweaking to bootargs to work; but right now that is a requirement, until 
a better solution is found/created.

Regards,

Omar
