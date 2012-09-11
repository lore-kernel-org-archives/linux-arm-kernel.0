From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 11 Sep 2012 11:34:56 +0000
Subject: [PATCH v2 3/3] usb: musb: omap: Add device tree support for
 omap musb glue
In-Reply-To: <CAAe_U6LwGn+qbSox7BofTg7sJUxqytew3s_73MOYZytHs2qEWw@mail.gmail.com>
References: <1347354580-5895-1-git-send-email-kishon@ti.com>
 <1347354580-5895-4-git-send-email-kishon@ti.com>	<504F0A33.9060606@ti.com>
 <CAAe_U6LwGn+qbSox7BofTg7sJUxqytew3s_73MOYZytHs2qEWw@mail.gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB0E00@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 16:54:37, ABRAHAM, KISHON VIJAY wrote:
> Hi,
> 
> On Tue, Sep 11, 2012 at 3:23 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >
> >
> > On 9/11/2012 2:39 PM, Kishon Vijay Abraham I wrote:
> >> Added device tree support for omap musb driver and updated the
> >> Documentation with device tree binding information.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  Documentation/devicetree/bindings/usb/omap-usb.txt |   33 ++++++++++++
> >>  drivers/usb/musb/omap2430.c                        |   54 ++++++++++++++++++++
> >>  2 files changed, 87 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/usb/omap-usb.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> >> new file mode 100644
> >> index 0000000..29a043e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> >> @@ -0,0 +1,33 @@
> >> +OMAP GLUE
> >> +
> >> +OMAP MUSB GLUE
> >> + - compatible : Should be "ti,omap4-musb" or "ti,omap3-musb"
> >> + - ti,hwmods : must be "usb_otg_hs"
> >> + - multipoint : Should be "1" indicating the musb controller supports
> >> +   multipoint. This is a MUSB configuration-specific setting.
> >> + - num_eps : Specifies the number of endpoints. This is also a
> >> +   MUSB configuration-specific setting. Should be set to "16"
> >> + - ram_bits : Specifies the ram address size. Should be set to "12"
> >> + - interface_type : This is a board specific setting to describe the type of
> >> +   interface between the controller and the phy. It should be "0" or "1"
> >> +   specifying ULPI and UTMI respectively.
> >> + - mode : Should be "3" to represent OTG. "1" signifies HOST and "2"
> >> +   represents PERIPHERAL.
> >> + - power : Should be "50". This signifies the controller can supply upto
> >> +   100mA when operating in host mode.
> >> +
> >> +SOC specific device node entry
> >> +usb_otg_hs: usb_otg_hs at 4a0ab000 {
> >> +     compatible = "ti,omap4-musb";
> >> +     ti,hwmods = "usb_otg_hs";
> >> +     multipoint = <1>;
> >> +     num_eps = <16>;
> >> +     ram_bits = <12>;
> >> +};
> >
> >
> > reg and interrupt properties are missing here.
> >
> > I would encourage to specify "reg" and "interrupt" properties in every
> > node getting newly added to the OMAP DTS files.
> 
> Sure. will add that in my next version.
> 

I saw there is some discussion going-on for which baseline to use, so make 
sure that you test the patches on top of below patch (already available in 
linux-omap/devel-dt)

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=b82b04e8eb27abe0cfe9cd7bf4fee8bb1bb9b013


Thanks,
Vaibhav
> Thanks
> Kishon
> 
