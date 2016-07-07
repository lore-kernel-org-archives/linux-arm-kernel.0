From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 11:24:53 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm,
 nvram_file_name dt property
In-Reply-To: <27f6d3d3-4bcc-8572-4c7b-b44966ad72f4@broadcom.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <3996482.D5xdKXDiGl@wuerfel>
 <27f6d3d3-4bcc-8572-4c7b-b44966ad72f4@broadcom.com>
Message-ID: <5859938.CkoVuKNmJq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 7, 2016 11:16:59 AM CEST Arend Van Spriel wrote:
> On 7-7-2016 10:46, Arnd Bergmann wrote:
> > On Wednesday, July 6, 2016 9:19:41 PM CEST Arend Van Spriel wrote:
> >> On 6-7-2016 15:42, Arnd Bergmann wrote:
> >>> On Wednesday, July 6, 2016 10:08:55 AM CEST Arend Van Spriel wrote:
> >>>> On Tue, Jul 5, 2016 at 3:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I'm a bit confused by the interdependencies now. You say that there are
> > board ID/rev values stored in OTP. What exactly prevents us from just
> > using those to generate a file name to look up the nvram file on disk
> > for the remaining values?
> > 
> > Do we require the firmware to be running before we can read the OTP,
> > or are there cases where the board ID in OTP is wrong or missing?
> 
> Well, both. Primarily we need firmware running to get the info. If board
> ID is missing in OTP the value from nvram file is used. If board ID in
> OTP is wrong we are screwed 

Ok.

> > If we can't rely on OTP for one of those reasons and instead add two
> > properties for boardtype/boardrev, I don't think that requires a
> > change of the compatible string, we would just document those two
> > as optional properties.
> 
> Right. I suppose the bindings update and driver update should preferably
> be in the same kernel release although bindings are supposedly OS agnostic.

It's a one-way dependency, we shouldn't add the kernel code handling
the property without having agreed on and updated the binding first.

	Arnd
