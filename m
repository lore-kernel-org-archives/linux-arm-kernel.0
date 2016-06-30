From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jun 2016 13:31:07 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm,
 nvram_file_name dt property
In-Reply-To: <8d8bd933-717b-48e4-f002-7b834abed6fd@redhat.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <CAOiHx==82LHOeQMNVD+dybFifXX690Q6AJTcMBMynjSfUOyGUw@mail.gmail.com>
 <8d8bd933-717b-48e4-f002-7b834abed6fd@redhat.com>
Message-ID: <3960223.GqB9zXL8s8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 30, 2016 12:25:15 PM CEST Hans de Goede wrote:
> > So then how about making use of a more specific compatible string?
> >
> > e.g.
> >
> > brcmf {
> >         compatible = "foo,ap6210", "brcm,bcm4329-fmac";
> >         ...
> > };
> >
> > and if the compatible has more than one element you request
> > FW_NAME_<compatible>.txt as the nvram file. Or try each comptible (and
> > lastly no suffix) until you get a match. (AFAICT, this is what the
> > "model" property was originally intended for anyway, but almost nobody
> > did it right, and everyone put a user readable string into "model" for
> > boards instead of the ePAPR defined compatible string).
> 
> Hmm, interesting idea. Not sure how easy / hard it will be to implement
> this, but from a dt binding point of view it seems elegant.
> 
> Kalle, Arend, what do you think of this ?

I think that's reasonable. Also, we have precedent for using things like
the boardid as part of the compatible string, which would help do what
Kalle suggested earlier with "nvram-<boardtype>-<boardrev>.txt",
as we get that for free by trying out all the compatible strings.

	Arnd
