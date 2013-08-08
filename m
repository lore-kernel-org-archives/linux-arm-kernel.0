From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 Aug 2013 09:31:04 -0400
Subject: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Message-ID: <52039D98.8080309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
> Hi,
> 
> This is the third version of the patch series for adding basic suspend-resume
> support for AM33XX, previously submitted by Vaibhav Bedia. This patchset 
> is based on 3.11-rc4 and depends on a forthcoming patchset from Suman Anna
> that adds mailbox support for the wkup_m3. The patches at [1], [2], and [3] are 
> required for the pm code to properly suspend and resume.
> 
> The PM code uses the firmware interface and expects the userspace to load 
> the WKUP_M3 binary before the suspend-resume functionality is made available.
> The binary file (and the source-code for WKUP_M3) can be obtained from the 
> 'next2' branch at [4]. The WKUP_M3 binary can either be loaded post bootup 
> via the sysfs entry './sys/devices/ocp.2/wkup_m3.4/firmware' or it can be 
> included in the kernel image as part of the build process.
> 
> Suspend to mem is tested on am335x-bone and am335x-evm.
> 
> More details on AM335x suspend-resume are provided within the commit logs
> for each patch.
> 
> Changes in v3:
> - Moved wkup_m3 code into separate driver
> - Split up ti_emif header move
> - Addressed clean-up comments
> - Removed mailbox patches
> - v2-v3 Discussion:
> http://marc.info/?l=linux-arm-kernel&m=135698501821090&w=4
> 
Please CC people who have at least reviewed the last version of
the series. Couple of patches I was CC'ed o.w I would missed this series.

Regards,
Santosh
