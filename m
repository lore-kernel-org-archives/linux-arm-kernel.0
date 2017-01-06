From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 6 Jan 2017 06:01:17 +0000
Subject: [PATCH v4 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <CAL_JsqKFF2g7_y6kS_A33wDQE3Sw5mJdoUj8wGaX5ZbQ6pK_zQ@mail.gmail.com>
References: <1483536954-27203-1-git-send-email-appanad@xilinx.com>
 <1483536954-27203-3-git-send-email-appanad@xilinx.com>
 <20170104152613.hhdptwsyg73ev3dz@rob-hp-laptop>
 <C246CAC1457055469EF09E3A7AC4E11A4A660958@XAP-PVEXMBX01.xlnx.xilinx.com>
 <CAL_JsqKFF2g7_y6kS_A33wDQE3Sw5mJdoUj8wGaX5ZbQ6pK_zQ@mail.gmail.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A66111B@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

	Thanks for the review...

 [Snip]
> > -- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> >> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> >> > @@ -66,6 +66,8 @@ Optional child node properties:
> >> >  Optional child node properties for VDMA:
> >> >  - xlnx,genlock-mode: Tells Genlock synchronization is
> >> >     enabled/disabled in hardware.
> >> > +- xlnx,fstore-config: Tells Whether Frame Store Configuration is
> >> > +   enabled/disabled in hardware.
> >>
> >> What's the default (when not present)? That should be the most common
> case.
> >> Looks like the code treats this as bool, but that's not clear here.
> >> The name is not clear what it is doing. Enabling or disabling the feature?
> >
> > Default value is zero...
> > When this property is present it tells hardware is configured for frame store
> configuration.
> 
> So most people will not want "frame store configuration"?

Since the driver is for SoftIP (I mean fpga ip) default h/w configuration of this IP is frame store
Configuration disabled that's in the driver making default value of this configuration as zero.

If users are trying a use case where this configuration should be enabled but in the h/w it is disabled.
In this case driver will warn users to enable this frame store configuration in the h/w.
So that users can enable it in their h/w.

Please let me know if the above expiation is not clear will explain in detail...

> 
> > Will fix the explanation part in the next version like below.
> >  xlnx,fstore-config: Tells hardware is configured for frame store configuration.
> > Is the above explanation clear???
> 
> No, I mean make it obvious from the name of the property:
> xlnx,fstore-config-enable or xlnx,fstore-enable
> 
> And the description needs to say it is boolean.

Sure will fix in the next version...

Regards,
Kedar.

> 
> Rob
