From: stern@rowland.harvard.edu (Alan Stern)
Date: Sun, 2 Jun 2013 14:20:34 -0400 (EDT)
Subject: [PATCH V2 1/2] USB: OHCI: make ohci-platform a separate driver
In-Reply-To: <CAJFYCKGU2u6EQ8FoG-7uDk6o_uTWad=F7SDRNMjLTQGvMxZOwA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306021419490.16951-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2 Jun 2013, Manjunath Goudar wrote:

> On 31 May 2013 19:37, Alan Stern <stern@rowland.harvard.edu> wrote:
> 

> > > +     return ohci_setup(ohci_to_hcd(ohci));
> >
> > You don't need to use ohci_to_hcd(), because the hcd value is already a
> > parameter in this function.
> >
> >
> After setting ohci's flag and  num_ports,we need to convert ohci to hcd
> that is what called ohci_to_hcd() function.

No, you don't need to convert it.  Just do:

	return ohci_setup(hcd);

Alan Stern
