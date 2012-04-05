From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Apr 2012 10:35:09 +0530
Subject: [PATCH V2 3/4] pinctrl: Add SPEAr3xx pinctrl drivers
In-Reply-To: <4F7CCA7D.7070601@wwwdotorg.org>
References: <cover.1333538869.git.viresh.kumar@st.com>
 <2a78bbfab59b531adef0820f34f683dd736d3a3a.1333538870.git.viresh.kumar@st.com>
 <4F7CCA7D.7070601@wwwdotorg.org>
Message-ID: <4F7D2805.7010201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2012 3:56 AM, Stephen Warren wrote:
>> > +- st,pinmux-mode: Mandatory for SPEAr300 and SPEAr320
>> > +	- Its values for SPEAr300:
>> > +		- NAND_MODE		: <0>
>> > +		- NOR_MODE		: <1>
>> > +		- PHOTO_FRAME_MODE	: <2>
>> > +		- LEND_IP_PHONE_MODE	: <3>
>> > +		- HEND_IP_PHONE_MODE	: <4>
>> > +		- LEND_WIFI_PHONE_MODE	: <5>
>> > +		- HEND_WIFI_PHONE_MODE	: <6>
>> > +		- ATA_PABX_WI2S_MODE	: <7>
>> > +		- ATA_PABX_I2S_MODE	: <8>
>> > +		- CAML_LCDW_MODE	: <9>
>> > +		- CAMU_LCD_MODE		: <10>
>> > +		- CAMU_WLCD_MODE	: <11>
>> > +		- CAML_LCD_MODE		: <12>
>> > +	- Its values for SPEAr320:
>> > +		- AUTO_NET_SMII_MODE	: <0>
>> > +		- AUTO_NET_MII_MODE	: <1>
>> > +		- AUTO_EXP_MODE		: <2>
>> > +		- SMALL_PRINTERS_MODE	: <3>
>> > +		- EXTENDED_MODE		: <4>
> I'm not sure what this is. Is it representing packaging options on the
> SoC or something like that?

These aren't packaging options but Usage specific muxing options. Customers
can have different application scenarios where they need different group
of peripherals or their modes. And that kind of muxing is provided by these
modes. Within these modes, we can again have muxing of peripherals present
for that mode.

> I'd personally expect the pinctrl driver to
> expose the raw pinmux HW module's capabilities and each board's .dts
> file to pick how to configure each option, rather than providing canned
> options, but I guess not everyone agrees.

I believe this is what my driver is doing. It provides the raw functionality
provided by SoC, and now board dts can select mode and muxing options.

-- 
viresh
