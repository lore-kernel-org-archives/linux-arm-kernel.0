From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 17:41:13 +0200
Subject: [GIT PULL 1/3] Keystone SOC driver updates for 4.4
In-Reply-To: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
References: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
Message-ID: <5870815.PiO7rCVXjJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 10:19:18 Santosh Shilimkar wrote:
> Couple of patches for ARM Keystone SOC drivers
>         - irq affinity bug fix
>         - display the firmware name
> 
> ----------------------------------------------------------------
> Murali Karicheri (2):
>       soc: ti: reset irq affinity before freeing irq
>       soc: ti: display firmware file name as part of boot log
> 
>  .../bindings/soc/ti/keystone-navigator-qmss.txt      | 20 +++++++++++++++++++-
>  drivers/soc/ti/knav_qmss_acc.c                       |  4 ++++
>  drivers/soc/ti/knav_qmss_queue.c                     |  3 +++
>  3 files changed, 26 insertions(+), 1 deletion(-)

The new text you add to the binding document doesn't really seem to
belong in there, so I'm not pulling this until we've discussed how
this should be better handled.

Ideally, the firmware should just get merged into the linux-firmware.git
tree.

Regarding the method of storing the firmware file name in DT, we
recently had a longer discussion about that and basically concluded
that this doesn't work for most devices, in particular when the
communication between the driver and the firmware uses an interface
that is not 100% stable and can change depending on the firmware
blob.

Can you guarantee that there will never be changes to the interface?
If not, we should try to come up with a better mechanism here, and
only provide the current method for backwards compatibility.

	Arnd
