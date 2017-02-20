From: socketcan@hartkopp.net (Oliver Hartkopp)
Date: Mon, 20 Feb 2017 08:56:43 +0100
Subject: iproute2 not function on CAN FD
In-Reply-To: <F9F4555C4E01D7469D37975B62D0EFBB4D7587@CHN-SV-EXMX07.mchp-main.com>
References: <F9F4555C4E01D7469D37975B62D0EFBB4D7587@CHN-SV-EXMX07.mchp-main.com>
Message-ID: <f4c78670-8c25-8ee3-5167-126d49ad5b00@hartkopp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2017 02:12 AM, Wenyou.Yang at microchip.com wrote:

> I am testing the CAN FD of M_CAN on the SAMA5D2 Xplained board,
> when using the ip tool from iprounte2 suite to set the CAN interface,
> it doesn't work with the message "RTNETLINK answers: Operation not supported".
> --->8----
> # ip link set can0 type can bitrate 125000 dbitrate 8000000 fd on
> RTNETLINK answers: Operation not supported

Please try:

# ip link set can0 type can bitrate 125000 dbitrate 8000000 fd on 
fd-non-iso on

The driver for the M_CAN IP core 3.0.x in the mainline kernel supports a 
NON_ISO IP core.

This non-iso setting is fixed with this v3.0.x M_CAN and we decided to 
make this configuration explicit - as all other options run into a mess.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=bb208f144cf3f59d8f89a09a80efd04389718907

Did that help?

Regards,
Oliver
