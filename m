From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 31 May 2013 10:05:41 -0400 (EDT)
Subject: [RFC PATCH 2/2] USB: OHCI: add a name for the platform-private
 field
In-Reply-To: <CAJFYCKECv-a8TkngRZzKfPi4apRTRtjDj2tQfRMJS94n7sSsFQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1305311005050.1276-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 May 2013, Manjunath Goudar wrote:

> On 30 May 2013 22:56, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Thu, 30 May 2013, Manjunath Goudar wrote:
> >
> > > This patch adds an ohci->priv field for private use by OHCI
> > > platform drivers.
> > >
> > > Until now none of the platform drivers has used this private space,
> > > but that's about to change in the next patch of this series.
> >
> > As far as I'm concerned, this doesn't need to be in a patch of its own.
> > It can be merged into the 1/3 patch of the previous series.  After all,
> > that patch adds the extra_priv_size field in ohci_driver_overrides,
> > which doesn't make much sense unless there's a way to refer to the
> > private part of the ohci_hcd structure
> 
> 
> 
>  Already 1/3 patch is merged into main line kernel.

Yeah, too late now.

> Two days back only I started making ohci-spera a separate driver ,that time
> I felt extra_priv_size field is required in ohci_driver_overrides that what
> I created separate patch.
> 
> extra_priv_size patch is related to Spear patch,If you are agree,I can add
> this patch with Spear patch,making Spear patch series.

No, we may as well keep it separate like this.

Alan Stern
