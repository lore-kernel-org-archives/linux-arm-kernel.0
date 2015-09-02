From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Sep 2015 00:04:09 +0100
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <CAD=FV=U2BR=Qk2cVS-cq78Rx=VjriZiE6nC3cn+_SBHx2_5ihg@mail.gmail.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=U2BR=Qk2cVS-cq78Rx=VjriZiE6nC3cn+_SBHx2_5ihg@mail.gmail.com>
Message-ID: <20150902230408.GR21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 04:00:07PM -0700, Doug Anderson wrote:
> Russell,
> 
> On Wed, Sep 2, 2015 at 3:50 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> I think you may want to add "adap->dev.of_node = hdmi->dev->of_node;"
> >> here.  That will allow device trees to specify the i2c bus by using an
> >> alias.
> >
> > Never copy the of_node from one device to another.  That allows the
> > bus matching to unintentionally match the of_node against the wrong
> > driver.
> 
> So does that mean we need to create a sub-node for the i2c bus if we
> want something like this?
> 
> 
> > Also, is it appropriate to hook non-DDC devices to a DDC bus?  I suspect
> > that's asking for trouble.
> 
> I doubt it's appropriate.  Why do you ask?

To find out why you want to "specify the I2C bus".

Surely if we're talking about the DDC bus, we either want to use a
separate I2C bus (in which case the HDMI DT description needs to
specify which I2C bus to use) or we want to use the HDMI-internal
I2C bus, which being part of the HDMI driver, the HDMI driver will
know how to find it itself - there should be no need to put an
explicit ddc-i2c-bus self-reference there in that case.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
