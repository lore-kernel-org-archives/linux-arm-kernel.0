From: joel.schopp@amd.com (Joel Schopp)
Date: Tue, 29 Jul 2014 09:19:38 -0500
Subject: [PATCH v7 07/11] arm64: mm: Implement 4 levels of translation
 tables
In-Reply-To: <ACF42928-55EE-4466-B217-982839BB98C4@gmail.com>
References: <CAGoO6fLT6B_vx+Wtm6bKHD6YkjQcM8f=deD7SDP3BR_uC+1c5w@mail.gmail.com>
 <ACF42928-55EE-4466-B217-982839BB98C4@gmail.com>
Message-ID: <53D7AD7A.8050706@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> Here's a good example of where we run into trouble equating page table
>> addressable bits with hardware addressable bits.  If VA_BITS is 48 due
>> to 4K 4 level page tables but is running on a 42 bit system this will
>> end up being out of range.
> Is your concern that CPU issues 48-bit address to MMU on 42-bit hardware?
> Have you tested this patch series on your hardware?
>
> - Jungseok Lee

That is my concern.  I did test the patch on my hardware with the
following results:
64k pages, 2 levels 42 bit VA - worked (no regression)
64k pages, 3 levels 48 bit VA- didn't boot
4k pages, 4 levels 42 bit VA - didn't boot
4k pages, 4 levels 48 bit VA - didn't boot
