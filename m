From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 17 Dec 2013 23:16:31 +0100
Subject: [PATCH 3/5] arm: shmobile: r7s72100: add nodes for i2c
 controllers to dtsi
In-Reply-To: <20131217221309.GD1196@katana>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1632121.4oJZuIln5n@avalon> <20131217221309.GD1196@katana>
Message-ID: <1626395.klZkGtWWeG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tuesday 17 December 2013 23:13:09 Wolfram Sang wrote:
> On Tue, Dec 17, 2013 at 10:55:31PM +0100, Laurent Pinchart wrote:
> > On Tuesday 17 December 2013 22:44:36 Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa@sang-engineering.com>
> > > 
> > > I decided to put the pinmuxing into the dtsi file since there is only
> > > one pinmux posiibility which one probably wants to have when using the
> > > bus.
> 
> I tried to explain here why the pin-groups are in the dtsi.
> 
> > > +		riic0_pins: i2c0 {
> > > +			renesas,groups = "riic0_scl_p1_0", "riic0_sda_p1_1";
> > > +			renesas,function = "riic0";
> > > +		};
> > > +
> > > +		riic1_pins: i2c1 {
> > > +			renesas,groups = "riic1_scl_p1_2", "riic1_sda_p1_3";
> > > +			renesas,function = "riic1";
> > > +		};
> > > +
> > > +		riic2_pins: i2c2 {
> > > +			renesas,groups = "riic2_scl_p1_4", "riic2_sda_p1_5";
> > > +			renesas,function = "riic2";
> > > +		};
> > > +
> > > +		riic3_pins: i2c3 {
> > > +			renesas,groups = "riic3_scl_p1_6", "riic3_sda_p1_7";
> > > +			renesas,function = "riic3";
> > > +		};
> > 
> > The SoC allows other options for the I2C pin groups. Instead of declaring
> > all possible groups here, I think we should thus only add the groups that
> > are really used to the board .dts files.
> 
> Really? Couldn't find any. This is why I included it here: since it is
> the only option, people probably want to use it when they activate the
> bus.

My bad, sorry, I've misread patch 1/5 and spoke too fast :-/ I thus makes 
sense to add the groups here.

> > > +		clock-frequency = <100000>;
> > 
> > Isn't that a board-specific property ?
> 
> It is meant as a sane default. Can be overridden.

OK.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/baa1d48d/attachment.sig>
