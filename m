From: msalter@redhat.com (Mark Salter)
Date: Tue, 08 Sep 2015 13:53:27 -0400
Subject: [Linaro-acpi] [RFC 3/5] acpi/serial: add DBG2 earlycon support
In-Reply-To: <20150908171744.GQ10728@bivouac.eciton.net>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <1441716217-23786-4-git-send-email-leif.lindholm@linaro.org>
 <1441730339.5459.8.camel@redhat.com>
 <20150908171744.GQ10728@bivouac.eciton.net>
Message-ID: <1441734807.5459.18.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-08 at 18:17 +0100, Leif Lindholm wrote:
> > >      */
> > > -   if (!buf || !buf[0])
> > > -           if (IS_ENABLED(CONFIG_OF_FLATTREE))
> > > +   if (!buf || !buf[0]) {
> > > +           if (!acpi_disabled)
> > 
> > How do we know for sure that "acpi" has been parsed before "earlycon"?
> 
> Because "arch" comes before "drivers" in kernel image link order.
> *twitch*
> Yes, not the best argument ever.
> 

I don't think that matters. Things are parsed in order they are
found on cmdline (except for early vs late distinction).
