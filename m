From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 16 Nov 2015 20:18:55 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <20151116195334.GL8644@n2100.arm.linux.org.uk>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <20151116181718.GW8644@n2100.arm.linux.org.uk>
 <HK2PR06MB056161DA1A57638A1D7305D58A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20151116195334.GL8644@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB0561019D9F96CF709040592C8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> That's much harder to do - generally for XIP, people are space limited 
> (which is why they're using XIP rather than putting the kernel in RAM.)
> They won't take kindly to having the kernel image bloated by 1MB just to
> pad it out so that the init stuff can be unmapped.
>
> However, from the security point of view, the less that's mapped at known
> addresses, the better.


Maybe the only true solution is to have some additional XIP Kconfig option that tells the kernel to not copy any of the init or data sections at all at boot, but instead leave it up to pre-boot to preload the physical locations with the correct values. That would get rid of your 1MB bloated boundary and you could even save some valuable XIP-able ROM/Flash space (you could pre-load from serial flash).

However, while that might provide more flexibility and ROM savings, it means now the pre-boot needs to know what values need to get pre-loaded where...adding more complexity to what right now is a very simple boot (set the PC and run).


- Chris
