From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Jan 2017 15:52:25 +0100
Subject: [PATCH net-next v4 0/2] Add support for the ethernet switch on
 the ESPRESSObin
In-Reply-To: <87tw9dbn2m.fsf@free-electrons.com>
References: <20161221125734.1034-1-romain.perier@free-electrons.com>
 <87tw9dbn2m.fsf@free-electrons.com>
Message-ID: <20170105145225.GI4229@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 03:25:53PM +0100, Gregory CLEMENT wrote:
> Hi David,
>  
>  On mer., d?c. 21 2016, Romain Perier <romain.perier@free-electrons.com> wrote:
> 
> > This set of patches adds support for the Marvell ethernet switch 88E6341.
> > It also add the devicetree definition of this switch to the DT board.
> 
> The forth version of this series had been sent while the net-next merge
> window was closed so I think it was missed.

Having done a bit more research, i'm pretty sure the second patch is
wrong. The 88E6341 is not compatible with the 6352, it is a different
family. It might be more like the 6390. So supporting it will need a
side-by-side comparison of the datasheet against the 6352 and the
6390, and the correct selection of the ops.

      Andrew
