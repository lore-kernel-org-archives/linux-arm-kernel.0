From: nbd@nbd.name (Felix Fietkau)
Date: Mon, 1 Oct 2018 13:57:22 +0200
Subject: [PATCH] mt76: fix header guard macro define names
In-Reply-To: <20180930225715.18491-1-colin.king@canonical.com>
References: <20180930225715.18491-1-colin.king@canonical.com>
Message-ID: <ae443a0d-9272-d538-ee85-6d5bf1231db8@nbd.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-10-01 00:57, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The header guards that are #defined are different from those being
> checked.  Fix this by #defining them to the correct name.
> 
> Fixes clang warnings:
> drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h:17:9:
> warning: '__MT76x02_MCU_H' is used as a header guard here, followed
> by #define of a different macro [-Wheader-guard]
> 
> drivers/net/wireless/mediatek/mt76/mt76x02_usb.h:17:9:
> warning: '__MT76x02_USB_H' is used as a header guard here, followed
> by #define of a different macro [-Wheader-guard]
> 
> Fixes: 905db7470199 ("mt76: usb: move mt76x02 mcu code in mt76x02-usb module")
> Fixes: edaa580bc830 ("mt76: move shared mcu_calibrate routine in mt76x02-lib module")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Merged, thanks.

- Felix
