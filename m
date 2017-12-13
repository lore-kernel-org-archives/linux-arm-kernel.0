From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Dec 2017 16:04:32 +0000
Subject: [PATCH 05/12] arm64: mm: Remove VMALLOC checks from
 update_mapping_prot(.)
In-Reply-To: <20171212153923.a7z6kcowxj7thljy@capper-debian.cambridge.arm.com>
References: <20171204141313.31604-1-steve.capper@arm.com>
 <20171204141313.31604-6-steve.capper@arm.com>
 <CAKv+Gu80J1vGn6V6Z3eXajDos=sjY_fLhUQP=-n0A8MyunTfgQ@mail.gmail.com>
 <20171212153923.a7z6kcowxj7thljy@capper-debian.cambridge.arm.com>
Message-ID: <20171213160431.vlasctskuwmkm6xh@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 03:39:23PM +0000, Steve Capper wrote:
> It is not apparent to me how mark_linear_text_alias_ro(.) guarantees
> that no page table entries for the linear map are split, though.

map_mem() ensures that when mapped via __map_memblock(), no contiguous
entries are created. Also both ends of the _text..__init_begin would be
mapped to the granularity permitted by their alignment so that no later
splitting is necessary.

-- 
Catalin
