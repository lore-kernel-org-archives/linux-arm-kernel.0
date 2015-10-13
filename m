From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 13 Oct 2015 09:56:37 -0400
Subject: [PATCH v2 0/4] soc: ti: knav_qmss: enable accumulator queue
 support
In-Reply-To: <1444679211-823-1-git-send-email-m-karicheri2@ti.com>
References: <1444679211-823-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <561D0D95.1040401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 03:46 PM, Murali Karicheri wrote:
> This patch series enable accumulator queue support for K2 SoCs. Accumulator
> queues are a type of qmss queue that is monitored by the PDSP firmware and
> accumulated. Host is interrupted by PDSP firmware when packets become
> available in a ring buffer shared between the host and PDSP.
>
> There was an issue raised when merging the original patch set at
>   (1) https://lkml.org/lkml/2015/9/4/681
> 	[PATCH v1 1/2] soc: ti: display firmware file name as part of boot log
>   (2) https://lkml.org/lkml/2015/9/4/680
> 	[PATCH v1 2/2] ARM: dts: keystone: enable accumulator channels
>
> This series fixes the issues raised against above patch set. Key issues
> addressed.
>
> 	- Remove the firmware filename from DT and add it to the driver.
> 	  Use a name ks2_qmss_pdsp_acc48.bin. The idea is this can be a
> 	  soft link pointing to the real firmware file in file system.
>
> 	- Move the description of the driver design from DT document to one
> 	  under Documentation/arm/keystone/knav-qmss.txt. Update the this
> 	  document with location of acc firmware available under
> 	  linux-firmware.git.
>
> Additionally added accumulator queue support optional so that lack of
> firmware in the file system will not cause other queue types not available
> due to driver probe failure.
>
> Murali Karicheri (4):
>    Documentation: dt: soc: move driver description to a separate document
>    soc: ti: add firmware file name as part of the driver
>    ARM: dts: keystone: enable accumulator channels
>    soc: ti: qmss: make acc queue support optional in the driver
>
>   Documentation/arm/keystone/knav-qmss.txt           | 56 ++++++++++++++++++
>   .../bindings/soc/ti/keystone-navigator-qmss.txt    | 21 ++-----
>   arch/arm/boot/dts/k2e-netcp.dtsi                   | 23 ++++++++
>   arch/arm/boot/dts/k2hk-netcp.dtsi                  | 24 ++++++++
>   arch/arm/boot/dts/k2l-netcp.dtsi                   | 23 ++++++++
>   drivers/soc/ti/knav_qmss.h                         |  3 +-
>   drivers/soc/ti/knav_qmss_acc.c                     | 10 +++-
>   drivers/soc/ti/knav_qmss_queue.c                   | 67 ++++++++++++++--------
>   8 files changed, 183 insertions(+), 44 deletions(-)
>   create mode 100644 Documentation/arm/keystone/knav-qmss.txt
>
Santosh, Arnd,

Could you please review and let me know if there is any comment. If 
looks good, could you please merge to v4.4 next branch?

Murali
-- 
Murali Karicheri
Linux Kernel, Keystone
