From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Nov 2014 22:48:47 +0100
Subject: [PATCH v2 2/2] of: support passing console options with
 stdout-path
In-Reply-To: <CACxGe6tYZ8aE_TKw1cYMY5DDjpSXPSnhhAam-rG5NgdjpKJe+A@mail.gmail.com>
References: <1417023640-23464-1-git-send-email-leif.lindholm@linaro.org>
 <1417023640-23464-3-git-send-email-leif.lindholm@linaro.org>
 <20141126183052.GH3443@lunn.ch>
 <CACxGe6tYZ8aE_TKw1cYMY5DDjpSXPSnhhAam-rG5NgdjpKJe+A@mail.gmail.com>
Message-ID: <20141126214847.GJ3443@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 09:07:33PM +0000, Grant Likely wrote:
> On Wed, Nov 26, 2014 at 6:30 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Wed, Nov 26, 2014 at 05:40:40PM +0000, Leif Lindholm wrote:
> >> Support specifying console options (like with console=ttyXN,<options>)
> >> by appending them to the stdout-path property after a separating ':'.
> >>
> >> Example:
> >>         stdout-path = "uart0:115200";
> >
> > Hi Leif
> >
> > This should be documented somewhere under
> > Documentation/devicetree/bindings/
> >
> > Not sure where thought. Maybe a top level chosen.txt?
> 
> Actually, this one doesn't. It is already documented in ePAPR

Hi Grant

Humm, do i have an old version of ePAPR?

All i see is that in Table 3-4 It says:

stdout-path O <string> A string that specifies the full path to the
	      	       node representing the device to be used for
	      	       boot console output. If the character ":" is
	      	       present in the value it terminates the
	      	       path. The value may be an alias.

		       If the stdin-path property is not specified,
		       stdout-path should be assumed to define the input device.

So what is before the : is defined. What comes afterwards,
baudrate/parity/bits/flow control does not appear to the defined in
ePAPR. Should we not document the extension being added here?

       Andrew
