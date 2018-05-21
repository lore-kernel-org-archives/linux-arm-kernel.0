From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Mon, 21 May 2018 09:48:23 -0400
Subject: [PATCH] EDAC, ghes: Make platform-based whitelisting x86-only
In-Reply-To: <20180518112028.GD17285@pd.tnic>
References: <1526039543-180996-1-git-send-email-zhengqiang10@huawei.com>
 <20180511121901.GA12705@pd.tnic> <5AF90C70.408@huawei.com>
 <20180514094709.GC23049@pd.tnic>
 <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
 <20180514164720.GH23049@pd.tnic>
 <da776696-ddbf-c35e-1dd4-b6e0ce91aed6@arm.com>
 <20180516182958.GB17092@pd.tnic>
 <8602b133-e0fa-57e2-5159-9d34a1ded85f@arm.com>
 <20180518111132.GC17285@pd.tnic> <20180518112028.GD17285@pd.tnic>
Message-ID: <b1d606dc-527c-6a7d-ce80-a11ac852a5f9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2018 7:20 AM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>
> ARM machines all have DMI tables so if they request hw error reporting
> through GHES, then the driver should be able to detect DIMMs and report
> errors successfully (famous last words :)).
>
> Make the platform-based list x86-specific so that ghes_edac can load on
> ARM.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: James Morse <james.morse@arm.com>
> Tested-by: James Morse <james.morse@arm.com>
> Cc: Qiang Zheng <zhengqiang10@huawei.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Was it intentional to make idx=0 so that the pr_info later in this function no 
longer hits?

I don't see an issue with not printing out the long BIOS statement, but the 
number of DIMM sockets print could still be useful.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
