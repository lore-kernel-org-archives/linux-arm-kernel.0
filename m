From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 23 Mar 2016 14:30:11 +0100
Subject: [PATCH v2 0/6] mm/hugetlb: Fix commandline parsing behavior for
 invalid hugepagesize
In-Reply-To: <1458734844-14833-1-git-send-email-vaishali.thakkar@oracle.com>
References: <1458734844-14833-1-git-send-email-vaishali.thakkar@oracle.com>
Message-ID: <20160323133011.GG7059@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23-03-16 17:37:18, Vaishali Thakkar wrote:
> Current code fails to ignore the 'hugepages=' parameters when unsupported
> hugepagesize is specified. With this patchset, introduce new architecture
> independent routine hugetlb_bad_size to handle such command line options.
> And then call it in architecture specific code.
> 
> Changes since v1:
> 	- Separated different architecture specific changes in different
> 	  patches
> 	- CC'ed all arch maintainers

The hugetlb parameters parsing is a bit mess but this at least makes it
behave more consistently. Feel free to add to all patches
Acked-by: Michal Hocko <mhocko@suse.com>

On a side note. I have received patches with broken threading - the
follow up patches are not in the single thread under this cover email.
I thought this was the default behavior of git send-email but maybe your
(older) version doesn't do that. --thread option would enforce that
(with --no-chain-reply-to) or you can set it up in the git config. IMHO
it is always better to have the patchset in the single email thread.

-- 
Michal Hocko
SUSE Labs
