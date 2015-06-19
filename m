From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Jun 2015 17:44:12 +0100
Subject: [PATCH v5 1/6] drm: bridge/dw_hdmi: add audio support for more
 display resolutions
In-Reply-To: <1434730752-10829-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434730752-10829-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20150619164411.GU7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 20, 2015 at 12:19:12AM +0800, Yakir Yang wrote:
> Just like HDMISpecification 1.4 document descripted, the soure shall
> determine the fractional relationship between the TMDS clock an an
> audio reference clock, the sink may then recreate the audio clock from
> the TMDS clock by using an clock divider. So if we can make sink generate
> the correct samplerate, then we can say those display resolutions with
> this pixelclock could support audio play.
> 
> The exact relationship between the two clocks will be:
> 	128 * SampleRate = TmdsClock * N / CTS.
> So this patch would generate the correct N/CTS values, add audio support
> for the below  tmds clocks:
> 25.175MHz, 40MHz, 54MHz, 65MHz, 74.25MHz, 83.5MHz, 106.5MHz, 108Mhz

I think I've said this before.  The documentation for iMX6 (which is
freely available, unlike Rock-chips documentation, so you can look at
it yourself) specifies that only certain audio and video rates are
supported.  See the iMX6 manuals, the section on the HDMI Tx, sub-
section "CTS calculation".

It clearly states that values which do not appear in the table there
are "not supported".

Adding more rates to this code puts iMX6 outside of its specification.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
