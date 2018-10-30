From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 30 Oct 2018 09:15:37 +0100
Subject: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
In-Reply-To: <1540882551.23278.12.camel@mtkswgap22>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
 <20181029080708.GA32673@dhcp22.suse.cz>
 <20181029081706.GC32673@dhcp22.suse.cz>
 <1540862950.12374.40.camel@mtkswgap22>
 <20181030060601.GR32673@dhcp22.suse.cz>
 <1540882551.23278.12.camel@mtkswgap22>
Message-ID: <20181030081537.GV32673@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 30-10-18 14:55:51, Miles Chen wrote:
[...]
> It's a real problem when using page_owner.
> I found this issue recently: I'm not able to read page_owner information
> during a overnight test. (error: read failed: Out of memory). I replace
> kmalloc() with vmalloc() and it worked well.

Is this with trimming the allocation to a single page and doing shorter
than requested reads?
-- 
Michal Hocko
SUSE Labs
