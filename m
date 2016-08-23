From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 23 Aug 2016 14:44:49 +0800
Subject: [PATCH 0/2] Add support for iNet D978 Rev2 board
Message-ID: <20160823064451.25997-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a white brand Allwinner A33 tablet board by iNet.

It features a RTL8723BS Wi-Fi/BT combo chip, which is rarely seen on
low-end Allwinner tablets.

The first patch adds basical supports to the tablet, including the Wi-Fi
function of RTL8723BS. (It should be used with the out-of-tree driver at
https://github.com/hadess/rtl8723bs )

The second patch enables the UART1 on the board, which is connected to the
BT part of RTL8723BS. (In order to merge this patch, the patchset
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450774.html
should be firstly merged. It's the reason why I send this patch as a dedicated
patch and do not combine it in PATCH 1/2. And the Bluetooth function needs
a modified version of hciattach by Realtek, which can be now retrieved at
the GitHub, from https://github.com/NextThingCo/rtl8723bs_bt )
