From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Nov 2014 17:21:21 +0100
Subject: [PATCH] of: support passing console options with stdout-path
In-Reply-To: <20141125144439.07212C44343@trevor.secretlab.ca>
References: <1416867838-18652-1-git-send-email-leif.lindholm@linaro.org>
 <20141124230016.GP20238@lunn.ch>
 <20141125144439.07212C44343@trevor.secretlab.ca>
Message-ID: <20141125162121.GC3443@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > More worrying, barebox does not support the : either. So there is a
> > danger your bootloader suddenly goes silent after a dt blob update.
> 
> Is barebox parsing the property? Or updating it? Or both? I've got no
> problem with this patch, but we can also support things like the
> 'current-speed' property in the UART to set a default when the stdout
> path doesn't have any arguments.

Hi Grant

I'm no export with barebox. So i just grep'ed the code.

It parses the property. Also as with linux, of_find_node_by_path()
does not stop at : as you say it should.

There is one case of the property being updated, but that is only for
the PPC mpc85xx.

Barebox does not appear to use 'current-speed' at all.

	Andrew
