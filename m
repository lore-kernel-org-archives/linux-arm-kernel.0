From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Oct 2017 14:16:17 +0100
Subject: [PATCH] pinctrl: armada-37xx: Add edge both type gpio irq support
In-Reply-To: <CACRpkdbqjh5U5QoE_B+7GfSyDdHW-NCAvogGq-2n8j6L6nG-Gw@mail.gmail.com>
References: <20171019131003.9684-1-gregory.clement@free-electrons.com>
 <CACRpkdbqjh5U5QoE_B+7GfSyDdHW-NCAvogGq-2n8j6L6nG-Gw@mail.gmail.com>
Message-ID: <20171031131617.GA11647@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Patch applied.
> 
> The discussion here is interesting, it is customary for GPIO drivers
> to implement double-edge detection emulation by swapping the
> edge detector around like this.

Hi Linus

I was not aware this was customary.

> It might be possible to collect some generic information about
> this in the Documentation/gpio/driver.txt document.

Yes, i think it should be documented somewhere. Even in the use case
here, detecting an SD card being inserted/removed, you could get some
bounce on the microswitch, miss an edge, and be in the wrong state.

       Andrew
