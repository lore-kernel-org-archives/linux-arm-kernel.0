From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jul 2016 10:51:10 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm,
 nvram_file_name dt property
In-Reply-To: <1f44df41-0111-441b-4671-718eec0c4346@broadcom.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <3960223.GqB9zXL8s8@wuerfel>
 <1f44df41-0111-441b-4671-718eec0c4346@broadcom.com>
Message-ID: <5046715.4MWnq2SdoR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 30, 2016 9:23:56 PM CEST Arend Van Spriel wrote:
> 
> On 30-6-2016 13:31, Arnd Bergmann wrote:
> > On Thursday, June 30, 2016 12:25:15 PM CEST Hans de Goede wrote:
> >>> So then how about making use of a more specific compatible string?
> >>>
> >>> e.g.
> >>>
> >>> brcmf {
> >>>         compatible = "foo,ap6210", "brcm,bcm4329-fmac";
> >>>         ...
> >>> };
> >>>
> >>> and if the compatible has more than one element you request
> >>> FW_NAME_<compatible>.txt as the nvram file. Or try each comptible (and
> >>> lastly no suffix) until you get a match. (AFAICT, this is what the
> >>> "model" property was originally intended for anyway, but almost nobody
> >>> did it right, and everyone put a user readable string into "model" for
> >>> boards instead of the ePAPR defined compatible string).
> >>
> >> Hmm, interesting idea. Not sure how easy / hard it will be to implement
> >> this, but from a dt binding point of view it seems elegant.
> >>
> >> Kalle, Arend, what do you think of this ?
> 
> At first glance I like the suggestion, but this would mean updating the
> bindings document for each new wifi module that we want to add. Not a
> big problem, but it makes that I have a slight preference to using a
> property for it, eg. brcm,module = "ap6210";

I think we can be a little relaxed with the requirement for updating the
binding document here, as long as the binding lists all the strings that
are understood by the driver itself and documents that there can be
additional strings in it.

In particular, documenting how a compatible string that is made up from
the board id and revision should be unproblematic.

	Arnd
