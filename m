From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 18:16:14 +0100
Subject: [PATCH 6/6] iommu/arm-smmu: Make use of phandle iterators in
 device-tree parsing
In-Reply-To: <1459784962-9808-7-git-send-email-joro@8bytes.org>
References: <1459784962-9808-1-git-send-email-joro@8bytes.org>
 <1459784962-9808-7-git-send-email-joro@8bytes.org>
Message-ID: <20160414171613.GM4584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Mon, Apr 04, 2016 at 05:49:22PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Remove the usage of of_parse_phandle_with_args() and replace
> it by the phandle-iterator implementation so that we can
> parse out all of the potentially present 128 stream-ids.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/arm-smmu.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)

Looks good to me. Given that you probably want to keep this with the
related DT changes:

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
