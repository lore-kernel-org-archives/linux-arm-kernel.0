From: dev@blino.org (Olivier Blin)
Date: Tue, 03 May 2016 23:35:45 +0200
Subject: [PATCH v5] ARM: bcm2835: dt: Add the ethernet to the device trees
In-Reply-To: <1462172811-24206-1-git-send-email-lkundrak@v3.sk> (Lubomir
 Rintel's message of "Mon, 2 May 2016 09:06:51 +0200")
References: <1462172811-24206-1-git-send-email-lkundrak@v3.sk>
Message-ID: <m3lh3qrfim.fsf@euphor.blino.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> The hub and the ethernet in its port 1 are hardwired on the board.
>
> Compared to the adapters that can be plugged into the USB ports, this
> one has no serial EEPROM to store its MAC. Nevertheless, the Raspberry Pi
> has the MAC address for this adapter in its ROM, accessible from its
> firmware.
>
> U-Boot can read out the address and set the local-mac-address property of the
> node with "ethernet" alias. Let's add the node so that U-Boot can do its
> business.
>
> Model B rev2 and Model B+ entries were verified by me, the hierarchy and
> pid/vid pair for the Version 2 was provided by Peter Chen. Original
> Model B is a blind shot, though very likely correct.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Tested-by: Olivier Blin <dev@blino.org>

Though, I still need the following patch for this DT patch to be useful:
net/smscx5xx: use the device tree for mac address

Thanks for the update Lubomir

-- 
Olivier Blin - blino
