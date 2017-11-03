From: tj@kernel.org (Tejun Heo)
Date: Fri, 3 Nov 2017 06:28:26 -0700
Subject: [PATCH v2] ata: fixes kernel crash while tracing
 ata_eh_link_autopsy event
In-Reply-To: <1509620467-6679-1-git-send-email-rsahu@apm.com>
References: <1509620467-6679-1-git-send-email-rsahu@apm.com>
Message-ID: <20171103132826.GR3252168@devbig577.frc2.facebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 04:31:07PM +0530, Rameshwar Prasad Sahu wrote:
> When tracing ata link error event, the kernel crashes when the disk is
> removed due to NULL pointer access by trace_ata_eh_link_autopsy API.
> This occurs as the dev is NULL when the disk disappeared. This patch
> fixes this crash by calling trace_ata_eh_link_autopsy only if "dev"
> is not NULL.
> 
> v2 changes:
>  Removed direct passing "link" pointer instead of "dev" in trace API.
> 
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
