From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Jul 2016 11:12:07 -0500
Subject: [PATCH 1/4] brcmfmac: Add brcm,nvram_file_name dt property
In-Reply-To: <b18cd232-711a-b617-2f09-09c4bdf2c3c4@broadcom.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <20160701020836.GA1722@rob-hp-laptop>
 <b18cd232-711a-b617-2f09-09c4bdf2c3c4@broadcom.com>
Message-ID: <20160704161207.GA4592@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 10:17:37AM +0200, Arend Van Spriel wrote:
> 
> 
> On 1-7-2016 4:08, Rob Herring wrote:
> > On Wed, Jun 29, 2016 at 04:04:31PM +0200, Hans de Goede wrote:
> >> Add a brcm,nvram_file_name dt property to allow overruling the default
> >> nvram filename for sdio devices. The idea is that we can specify a
> >> board specific nvram file, e.g. brcmfmac43362-ap6210.txt for boards
> >> with an ap6210 wifi sdio module and ship this in linux-firmware, so
> >> that wifi will work out of the box, without requiring users to find
> >> and then manually install the right nvram file for their board.
> > 
> > What about putting its contents directly into DT? It's just text 
> > key/value pairs so it would match up well.
> 
> It would be an option, but I have no clue how to dig up documentation of
> these key,value pairs. The file is typically obtained from a wifi module
> vendor which would need to be converted to DT format, ie. prefix with
> "brcm," etc. From driver perspective this would mean it need to know
> keys. Currently, it just takes the file contents and sends it to the device.

Okay, if it is opaque, then probably best to treat as firmware and not 
change it.

Rob
