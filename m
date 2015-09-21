From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 21 Sep 2015 17:00:33 +0300
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <20150916221819.GJ21084@n2100.arm.linux.org.uk>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=XZ4cY4o-=vL79GDE4m57B+Rw_Yr_QwtB6T7DbQNzmU0Q@mail.gmail.com>
 <55F9D7F0.4070402@mentor.com>
 <CAD=FV=Vk+qziHohVL_Zaag0qqh_R6DnA1s-ppVFC=cBccAn4EA@mail.gmail.com>
 <20150916221819.GJ21084@n2100.arm.linux.org.uk>
Message-ID: <56000D81.9080509@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.09.2015 01:18, Russell King - ARM Linux wrote:
> On Wed, Sep 16, 2015 at 02:56:57PM -0700, Doug Anderson wrote:
>> Yes, I'd expect 100kHz and 400kHz.
>>
>> I agree that 50ms is non-trivial, but it's also not something you're
>> doing lots of.  I'd expect that the EDID is read over this channel at
>> cable plugin time and then not used much after that.  Adding an extra
>> 40ms (10ms vs 50ms) before we can access the TV doesn't seem terrible
>> for compatibility.
>>
>> Doing a quick scan for what others in mainline do:
>>
>> A few can be found with:
>>
>> $ git grep -A3 hdmiddc | grep clock-freq
>> arch/arm/boot/dts/stihxxx-b2120.dtsi-
>> clock-frequency = <100000>;
>> arch/arm/boot/dts/tegra30-apalis.dtsi-          clock-frequency = <100000>;
>> arch/arm/boot/dts/tegra30-beaver.dts-           clock-frequency = <100000>;
>> arch/arm/boot/dts/tegra30-colibri.dtsi-         clock-frequency = <100000>;
> 
> This is a sure way to propagate a bug.
> 
> I said in a previous email that you need to check the HDMI and CEA
> specs.  I've done this, and HDMI 1.3a specifies a maximum SCL clock
> rate of 100kHz.
> 
> So that's settled then.  100kHz is must be.  Using 400kHz is out of
> specification.
> 

FYI I've managed to measure SCL on iMX6, fast mode stands for 333KHz and
standard mode stands for 100KHz, therefore I'll set the latter mode.

--
With best wishes,
Vladimir
