From: dcbw@redhat.com (Dan Williams)
Date: Fri, 07 Apr 2017 15:09:18 -0500
Subject: [PATCH v2 3/4] bluetooth: hci_uart: add LL protocol serdev
 driver support
In-Reply-To: <CAL_Jsq+aM+xxbu=3v8_w9Ce+=t_pXmVWuisnckA8_8LOS-ftVA@mail.gmail.com>
References: <20170407143516.9945-1-robh@kernel.org>
 <1491584978.2136.21.camel@redhat.com>
 <CAL_Jsq+aM+xxbu=3v8_w9Ce+=t_pXmVWuisnckA8_8LOS-ftVA@mail.gmail.com>
Message-ID: <1491595758.2136.28.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-04-07 at 13:48 -0500, Rob Herring wrote:
> On Fri, Apr 7, 2017 at 12:09 PM, Dan Williams <dcbw@redhat.com>
> wrote:
> > On Fri, 2017-04-07 at 09:35 -0500, Rob Herring wrote:
> > > Turns out that the LL protocol and the TI-ST are the same thing
> > > AFAICT.
> > > The TI-ST adds firmware loading, GPIO control, and shared access
> > > for
> > > NFC, FM radio, etc. For now, we're only implementing what is
> > > needed
> > > for
> > > BT. This mirrors other drivers like BCM and Intel, but uses the
> > > new
> > > serdev bus.
> > > 
> > > The firmware loading is greatly simplified by using existing
> > > infrastructure to send commands. It may be a bit slower than the
> > > original code using synchronous functions, but the real
> > > bottleneck is
> > > likely doing firmware load at 115.2kbps.
> > 
> > Is there no way to put the TI-specific stuff into a TI UART module
> > rather than building it into the generic one?
> 
> In case it's not clear, all of HCI_LL is the TI specific part, not
> just what I'm adding. So you are talking about putting each UART BT
> protocol into a separate module. I'd assume that is doable, but seems
> orthogonal to this patch set. I'd also assume there was some reason
> that was not done already.

Ok, thanks for the explanation.  Wasn't clear at all from the file
paths in the source tree; it looked generic.

Dan
