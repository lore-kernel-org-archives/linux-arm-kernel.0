From: jcm@redhat.com (Jon Masters)
Date: Fri, 7 Sep 2018 02:22:49 -0400
Subject: [PATCH 0/5] 52-bit userspace VAs
In-Reply-To: <20180829124543.25314-1-steve.capper@arm.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
Message-ID: <53f6d3aa-ffd9-8452-4ad6-847132b975a9@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2018 08:45 AM, Steve Capper wrote:
> This patch series brings support for 52-bit userspace VAs to systems that
> have ARMv8.2-LVA and are running with a 48-bit VA_BITS and a 64KB
> PAGE_SIZE.
> 
> If no hardware support is present, the kernel runs with a 48-bit VA space
> for userspace.
> 
> Userspace can exploit this feature by providing an address hint to mmap
> where addr[51:48] != 0. Otherwise all the VA mappings will behave in the
> same way as a 48-bit VA system (this is to maintain compatibility with
> software that assumes the maximum VA size on arm64 is 48-bit).
> 
> This patch series applies to 4.19-rc1.
> 
> Testing was in a model with Trusted Firmware and UEFI for boot.

This is great stuff. I'm hoping to catch up at Connect and discuss.

Help me understand something. Without the kernel side of this patch, and
the increase in linear map for installed RAM, what upside do I see other
than being able to allocate from a higher VA space?

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
