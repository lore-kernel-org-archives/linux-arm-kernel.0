From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 6 Feb 2012 16:26:56 +0000
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <4F28AD1D.1000106@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
 <20120131095811.GB889@n2100.arm.linux.org.uk>
 <CAHkRjk4MnuHs6MZNds2YmufmY_29dSOoeCxX=ODZ5p23YEcjUw@mail.gmail.com>
 <4F28AD1D.1000106@gmail.com>
Message-ID: <20120206162656.GG26538@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 03:10:21AM +0000, bill4carson wrote:
> Why L_PTE_HUGEPAGE is needed?
> 
> hugetlb subsystem will call pte_page to derive the corresponding page 
> struct from a given pte, and pte_pfn is used first to convert pte into
> a page frame number.

Are you sure the pte_pfn() conversion is right? Does it need to be
different from the 4K pfn? I haven't seen any other architecture doing
shifts other than PAGE_SHIFT even for huge pages.

-- 
Catalin
