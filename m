From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon, 11 Oct 2010 17:08:23 +0300
Subject: [PATCH 3/3] mx51: Move OTG initialisation for all boards to a
	single file
In-Reply-To: <20101011131009.GY28242@pengutronix.de>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
	<2306a14fec6647b68a4aee1743a75d040ec141b1.1286412080.git.amit.kucheria@linaro.org>
	<20101007074853.GZ28242@pengutronix.de>
	<AANLkTimVo8uLHq4zCskBU4C_nWYiw89BxUw2FM_p3qhQ@mail.gmail.com>
	<20101011131009.GY28242@pengutronix.de>
Message-ID: <AANLkTinKirn9LQ9EoZWULUJ90U2rw=Qx60=q5f8C_9Hs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 4:10 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>>
>> Do you think something like this will be better? It looks even more
>> scattered to me, the usb configuration information is scattered across
>> platform_data and phy_data.
>
> My problem is not that it's scattered around platform_data and phy_data,
> but that it's not possible to add proper i.MX51 support without
> introducing a initialize_otg_port which wont' be flexible enough for
> future boards.
>
>>
>> Or did you want to get rid of platform_data->init too from the driver?
>
> No, I think we can't do this without breaking at least some boards. I
> found out that on some boards we have to configure the iomux pins and
> the rest of the USB hardware in a short time frame, otherwise we get
> ULPI errors.
>
> Sascha

So are the original patches(v2) to consolidate initialize_otg_port()
and introduce efikamx board support acceptable?

(I want to ensure I don't miss the next merge window, because Debian
wants to use these machines as their build machines)
