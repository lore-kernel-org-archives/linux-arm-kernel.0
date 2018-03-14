From: toshi.kani@hpe.com (Kani, Toshi)
Date: Wed, 14 Mar 2018 14:38:00 +0000
Subject: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
In-Reply-To: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
Message-ID: <1521038277.2693.131.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-14 at 14:18 +0530, Chintan Pandya wrote:
> Note: I was working on these patches for quite sometime
> and realized that Toshi Kani has shared some patches
> addressing the same isssue with subject
> "[PATCH 0/2] fix memory leak / panic in ioremap huge pages".
> I've taken slightly different approach here, so sending
> to the list, finally.

Hi Chintan,

Do you have any issue in my patchset?  If so, can you please comment on
them?  It complicates the thing when you send a different approach
without telling why a different approach is needed.  Your approach
purges TLB after updating pmd/pud, which I think is broken.  Can you
work on top of my patchset and properly implement pXd_free_pte_page()
for arm64?  I will send out my v2 today.
  
Thanks,
-Toshi
