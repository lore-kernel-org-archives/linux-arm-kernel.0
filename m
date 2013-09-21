From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sat, 21 Sep 2013 15:42:37 +0200
Subject: [PATCH 0/4] Add support for charging battery in Nokia RX-51
In-Reply-To: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <201309211542.38033@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 September 2013 10:50:35 Pali Roh?r wrote:
> This patch series finally bringing support for charging
> battery on Nokia N900 (RX-51) without any proprietary Nokia
> bits in userspace.
> 
> Pali Roh?r (4):
>   usb: musb: Call atomic_notifier_call_chain when status is
> changed power: isp1704_charger: Fix driver to work with
> changes introduced in v3.5
>   power: isp1704_charger: Add callback function set_current
>   RX-51: Add platform function and data for bq24150a charger
> 
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   56
> +++++++++++++- drivers/power/isp1704_charger.c              |
>  107 ++++++++++++++------------ drivers/usb/musb/omap2430.c  
>                |    3 + drivers/usb/phy/phy-twl4030-usb.c    
>        |    2 + include/linux/power/isp1704_charger.h       
> |    1 + 5 files changed, 117 insertions(+), 52 deletions(-)

Anton, can you review this patch series, specially power supply 
code (changes to isp1704_charger.c driver)?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130921/ac95098d/attachment.sig>
