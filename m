From: tj@kernel.org (Tejun Heo)
Date: Mon, 5 Jan 2015 08:59:50 -0500
Subject: [PATCH 2/2] ahci_xgene: Implement the workaround to support PMP
 enumeration and discovery for APM X-Gene SoC AHCI SATA Host Controller
 driver.
In-Reply-To: <20150105133005.GB15833@htj.dyndns.org>
References: <1420453305-15986-1-git-send-email-stripathi@apm.com>
 <1420453305-15986-3-git-send-email-stripathi@apm.com>
 <20150105133005.GB15833@htj.dyndns.org>
Message-ID: <20150105135950.GE15833@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 08:30:05AM -0500, Tejun Heo wrote:
> On Mon, Jan 05, 2015 at 03:51:45PM +0530, Suman Tripathi wrote:
> > Due to H/W errata, the controller is unable to save the PMP
> > field fetched from command header before sending the H2D FIS.
> > When the device returns the PMP port field in the D2H FIS, there is
> > a mismatch and results in command completion failure. The workaround
> > is to write the pmp value to PxFBS.DEV field before issuing any command
> > to PMP.
> > 
> > Signed-off-by: Suman Tripathi <stripathi@apm.com>
> 
> Applied 1-2 to libata/for-3.20.

Reverted due to conflicts with the endian fix patches.  Please rebase
these two on top of them.

Thanks.

-- 
tejun
