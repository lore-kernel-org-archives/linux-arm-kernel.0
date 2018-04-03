From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 3 Apr 2018 13:47:05 -0400
Subject: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
In-Reply-To: <CY1PR0701MB201215C9F38E8760732B595088A50@CY1PR0701MB2012.namprd07.prod.outlook.com>
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
 <1521736009-23387-4-git-send-email-okaya@codeaurora.org>
 <ac46b4e4-7e6c-c15f-06eb-01b1e4893d50@codeaurora.org>
 <CY1PR0701MB201215C9F38E8760732B595088A50@CY1PR0701MB2012.namprd07.prod.outlook.com>
Message-ID: <3f8de63a-9036-a5ac-2369-2d9af80bb6ef@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2018 3:42 AM, Kalderon, Michal wrote:
> The wmb before writel are used to make sure the
> HW observes the changes in memory before we trigger the doorbell. 

According to Linus, writel() guarantees observability. No extra
barrier is necessary.

https://www.mail-archive.com/netdev at vger.kernel.org/msg225806.html

There shouldn't be any wmb() in drivers unless it is used for a
very well-known reason. 

APIs like readX() and writeX() guarantee observability.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
