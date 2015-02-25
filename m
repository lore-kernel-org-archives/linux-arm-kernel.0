From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 25 Feb 2015 15:54:26 +0100
Subject: Ethernet Briding broken on APM Mustang on v4.0-rc1
In-Reply-To: <54EDD460.8080909@redhat.com>
References: <20150225124101.GD12827@cbox> <20150225134534.GE12827@cbox>
 <54EDD460.8080909@redhat.com>
Message-ID: <20150225145426.GA18388@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 07:55:44AM -0600, Mark Langsdorf wrote:
> On 02/25/2015 07:45 AM, Christoffer Dall wrote:
> >Update, apologies for noise,
> >
> >On Wed, Feb 25, 2015 at 01:41:01PM +0100, Christoffer Dall wrote:
> >>Hi,
> >>
> >>Configuring bridged networking on the APM Mustang platform doesn't work
> >>on v4.0-rc1.  It works fine on v3.19-rc1.
> >>
> >>When adding the interface to the bridge I get this error:
> >>
> >>can't add eth0 to bridge br0: Invalid argument
> >>
> >>Has anyone else seen this?
> >>
> >>Other ARMv8 platforms don't seem to be affected by this.
> >>
> >
> >It seems that on v4.0-rc1 the APM ethernet card no longer gets a mac
> >address (or rather, it gets 00:00:00:00:...) so assigning it an
> >appropriate address naturally does the trick.
> >
> >I have no idea which change caused this behavior though.
> 
> Did you update your firmware recently? The MAC address is
> stored as a UEFI shell variable and pushed into ACPI/DTB
> by the firmware. At one point in the development history,
> the symbol that held it changed from RGMII_MAC0 to MAC0.

No, only updated my kernel.

> 
> You can reset it by going into the UEFI shell and running:
> set MAC0 aa:bb:cc:dd:ee:ff
> replacing aa:bb:cc:dd:ee:ff with the MAC address.
> 

I'm not running UEFI, but U-Boot and it doesn't seem like U-Boot manages
to configure the hwaddr for Linux.

-Christoffer
