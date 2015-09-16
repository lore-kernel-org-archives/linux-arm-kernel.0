From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Sep 2015 23:18:19 +0100
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <CAD=FV=Vk+qziHohVL_Zaag0qqh_R6DnA1s-ppVFC=cBccAn4EA@mail.gmail.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=XZ4cY4o-=vL79GDE4m57B+Rw_Yr_QwtB6T7DbQNzmU0Q@mail.gmail.com>
 <55F9D7F0.4070402@mentor.com>
 <CAD=FV=Vk+qziHohVL_Zaag0qqh_R6DnA1s-ppVFC=cBccAn4EA@mail.gmail.com>
Message-ID: <20150916221819.GJ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 02:56:57PM -0700, Doug Anderson wrote:
> Yes, I'd expect 100kHz and 400kHz.
> 
> I agree that 50ms is non-trivial, but it's also not something you're
> doing lots of.  I'd expect that the EDID is read over this channel at
> cable plugin time and then not used much after that.  Adding an extra
> 40ms (10ms vs 50ms) before we can access the TV doesn't seem terrible
> for compatibility.
> 
> Doing a quick scan for what others in mainline do:
> 
> A few can be found with:
> 
> $ git grep -A3 hdmiddc | grep clock-freq
> arch/arm/boot/dts/stihxxx-b2120.dtsi-
> clock-frequency = <100000>;
> arch/arm/boot/dts/tegra30-apalis.dtsi-          clock-frequency = <100000>;
> arch/arm/boot/dts/tegra30-beaver.dts-           clock-frequency = <100000>;
> arch/arm/boot/dts/tegra30-colibri.dtsi-         clock-frequency = <100000>;

This is a sure way to propagate a bug.

I said in a previous email that you need to check the HDMI and CEA
specs.  I've done this, and HDMI 1.3a specifies a maximum SCL clock
rate of 100kHz.

So that's settled then.  100kHz is must be.  Using 400kHz is out of
specification.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
