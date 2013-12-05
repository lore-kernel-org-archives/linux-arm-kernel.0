From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Dec 2013 17:30:37 +0000
Subject: [RFC PATCH 0/2] arm64: Add support for 48-bit Physical Addresses
In-Reply-To: <CAC8NTUUHiaB3m+zmoPPKXTzWq82veNhT4gCERSQiLvKhfMvRyQ@mail.gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
 <5295D1A5.5090403@arm.com>
 <CAC8NTUXiMpjNh+GBTGcLDJ2hevskWnD6PE66ZaFxBAdUuy2nbg@mail.gmail.com>
 <5296330D.9010801@arm.com>
 <CAC8NTUVvLgNPdsSPY6Ms_D3JoyJR8AEFRH0=M7-kQEUegNVhKg@mail.gmail.com>
 <CAC8NTUUHiaB3m+zmoPPKXTzWq82veNhT4gCERSQiLvKhfMvRyQ@mail.gmail.com>
Message-ID: <20131205173036.GE17165@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 02:35:52PM +0000, Radha Mohan wrote:
> Before going for a next version of patch to fix breaking SMMU and KVM,
> I would like to know  about the best possible implementation.
> Should I go for a compile time option? I am not in favor of this. What
> are options if in future there's 16KB page support in the kernel.

As I said in the other email, separate the shifts definitions (primarily
page size dependent) from the type definitions (dependent on the number
of levels).

Just to understand your requirements better. Does your platform have
more than 256GB of RAM? With the current configuration, the VA space is
39-bit with 4K (which would allow 512GB minus some vmalloc and modules
space) and 42-bit with 64K pages (2TB minus vmalloc/modules).

-- 
Catalin
