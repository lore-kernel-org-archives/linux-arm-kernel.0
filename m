From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Feb 2014 12:01:16 +0100
Subject: [PATCH v2 4/6] ARM: firmware: add prepare_idle() operation
In-Reply-To: <1391747706-1847-5-git-send-email-acourbot@nvidia.com>
References: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
 <1391747706-1847-5-git-send-email-acourbot@nvidia.com>
Message-ID: <52FCA5FC.80504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 07.02.2014 05:35, Alexandre Courbot wrote:
> Some firmwares do not put the CPU into idle mode themselves, but still
> need to be informed that the CPU is about to enter idle mode before this
> happens. Add a prepare_idle() operation to the firmware_ops structure to
> handle such cases.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>   arch/arm/include/asm/firmware.h | 4 ++++
>   1 file changed, 4 insertions(+)

I wonder if .do_idle() couldn't simply return an appropriate error code 
to let the upper layer know that it should proceed with normal CPU idle 
activation, while still letting the firmware know that the CPU is going 
to idle.

Best regards,
Tomasz
