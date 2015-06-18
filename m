From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 18 Jun 2015 03:29:38 +0200
Subject: [ehci-orion] ETIMEOUT with ehci_setup()'s ehci_halt()
In-Reply-To: <557FE719.8040609@keymile.com>
References: <5571B38E.7080505@keymile.com> <20150605151930.GA16909@lunn.ch>
 <5572E4E8.2060405@gmail.com> <55758095.2030609@keymile.com>
 <557AC490.5040405@keymile.com> <557FE719.8040609@keymile.com>
Message-ID: <20150618012938.GD22072@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> One final update on this topic: the kernel config was missing the
> CONFIG_USB_EHCI_ROOT_HUB_TT option. It turns out that the USB IP embeded a
> Transaction Translator and there is a check in ehci_halt() that aborts the
> routine in case of a Transaction Translator in the ehci controller. The check
> however only works in the above option is enabled.

Maybe it would be worth detecting this and issuing a warning?

      Andrew
