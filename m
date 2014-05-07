From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 7 May 2014 11:09:21 -0400 (EDT)
Subject: [PATCHv4 01/20] usb: ehci-orion: use platform_get_irq() for DT
 probing
In-Reply-To: <1399470746-2948-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <Pine.LNX.4.44L0.1405071108540.1325-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 May 2014, Thomas Petazzoni wrote:

> Commit 77dae54ab385033e488d8b07045bc7f8d931740f ('ARM: Kirkwood:
> ehci-orion: Add device tree binding') added the Device Tree binding
> for the ehci-orion driver. To achieve that with the irq, it used the
> irq_of_parse_and_map() function when probed in DT-mode, and
> platform_get_irq() when probed in non-DT mode.
> 
> This is not necessary: platform_get_irq() works just as fine in
> DT-mode, since the conversion from DT information to 'struct resource'
> is done by the generic layers of the kernel.
> 
> Therefore, this commit switches back to use just platform_get_irq().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

For patches 1 - 4:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
