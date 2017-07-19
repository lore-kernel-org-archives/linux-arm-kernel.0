From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 19 Jul 2017 09:52:35 -0700
Subject: [PATCH 0/6] FlexRM driver improvements
In-Reply-To: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
References: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <9563f619-bcac-01cb-11c2-211697d0ac68@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch series all looks good.


On 17-07-19 02:55 AM, Anup Patel wrote:
> This patchset does various improvments to Broadcom FlexRM
> mailbox controller driver and also adds FlexRM DT nodes
> for Stingray SOC.
>
> The patches are based on Linux-4.13-rc1 and can also be
> found at flexrm-imp-v1 branch of
> https://github.com/Broadcom/arm64-linux.git
>
> Anup Patel (6):
>    mailbox: bcm-flexrm-mailbox: Set IRQ affinity hint for FlexRM ring
>      IRQs
>    mailbox: bcm-flexrm-mailbox: Add debugfs support
>    mailbox: bcm-flexrm-mailbox: Fix mask used in CMPL_START_ADDR_VALUE()
>    mailbox: Make message send queue size dynamic in Linux mailbox
>    mailbox: bcm-flexrm-mailbox: Set msg_queue_len for each channel
>    arm64: dts: Add FlexRM DT nodes for Stingray
>
>   .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   |  54 +++++++
>   .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   2 +
>   drivers/mailbox/bcm-flexrm-mailbox.c               | 160 ++++++++++++++++++++-
>   drivers/mailbox/mailbox.c                          |  15 +-
>   include/linux/mailbox_controller.h                 |   5 +-
>   5 files changed, 227 insertions(+), 9 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
>
Regards,
  Scott
