From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 3 Oct 2017 15:18:17 +0200
Subject: [PATCH v9 08/12] mm: zero reserved and unavailable struct pages
In-Reply-To: <20170920201714.19817-9-pasha.tatashin@oracle.com>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-9-pasha.tatashin@oracle.com>
Message-ID: <20171003131817.omzbam3js67edp3s@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 20-09-17 16:17:10, Pavel Tatashin wrote:
> Some memory is reserved but unavailable: not present in memblock.memory
> (because not backed by physical pages), but present in memblock.reserved.
> Such memory has backing struct pages, but they are not initialized by going
> through __init_single_page().

Could you be more specific where is such a memory reserved?
-- 
Michal Hocko
SUSE Labs
