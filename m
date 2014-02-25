From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Feb 2014 19:53:17 +0100
Subject: [PATCH v3 5/5] ARM: kirkwood: Add HP T5325 devices to
 {multi|mvebu}_v5_defconfig
In-Reply-To: <6144493.7kns7zvPT9@wuerfel>
References: <1393349643-6652-1-git-send-email-andrew@lunn.ch>
 <1393349643-6652-6-git-send-email-andrew@lunn.ch>
 <6144493.7kns7zvPT9@wuerfel>
Message-ID: <20140225185317.GA6762@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 07:19:33PM +0100, Arnd Bergmann wrote:
> On Tuesday 25 February 2014 18:34:03 Andrew Lunn wrote:
> > The HP T5325 has a PCI based VGA controller. Add the frame buffer
> > driver, and frame buffer support to the defconfig's. Additionally
> > add the soc audio framework and the necessary codec.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> Does the VGA console still work with the new PCI driver?

I've not plugged in a monitor, but i do see:

xgifb 0000:01:00.0: Relocate IO address: 10000 [00010030]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
xgifb 0000:01:00.0: chipid = 32
xgifb: SR14=51 DramSzie 2000000 ChannelNum 1
xgifb 0000:01:00.0: Framebuffer at 0xe0000000, mapped to 0xe1000000, size 32768k
xgifb 0000:01:00.0: MMIO at 0xe4000000, mapped to 0xe0a00000, size 256k
xgifb 0000:01:00.0: No or unknown bridge type detected
xgifb: Default mode is 800x600x16 (60Hz)

so it looks like the frame buffer is happy.
 
I will see if i can find a cable and a monitor.

 Andrew
