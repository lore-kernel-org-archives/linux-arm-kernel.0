From: tj@kernel.org (Tejun Heo)
Date: Mon, 5 Jan 2015 08:30:05 -0500
Subject: [PATCH 2/2] ahci_xgene: Implement the workaround to support PMP
 enumeration and discovery for APM X-Gene SoC AHCI SATA Host Controller
 driver.
In-Reply-To: <1420453305-15986-3-git-send-email-stripathi@apm.com>
References: <1420453305-15986-1-git-send-email-stripathi@apm.com>
 <1420453305-15986-3-git-send-email-stripathi@apm.com>
Message-ID: <20150105133005.GB15833@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 03:51:45PM +0530, Suman Tripathi wrote:
> Due to H/W errata, the controller is unable to save the PMP
> field fetched from command header before sending the H2D FIS.
> When the device returns the PMP port field in the D2H FIS, there is
> a mismatch and results in command completion failure. The workaround
> is to write the pmp value to PxFBS.DEV field before issuing any command
> to PMP.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Applied 1-2 to libata/for-3.20.

Thanks.

-- 
tejun
