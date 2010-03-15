From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 15 Mar 2010 17:09:40 +0000
Subject: QUERY: How to handle SOC Configuration (Peripheral
	Multiplexing) in linux
In-Reply-To: <4B9E65FB.1070501@billgatliff.com>
References: <4B9DB823.1040809@st.com>
	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
	<4B9DC239.90407@st.com> <4B9E2D7E.1020702@billgatliff.com>
	<4B9E5A29.1090407@st.com> <4B9E65FB.1070501@billgatliff.com>
Message-ID: <20100315170940.GB13878@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 11:53:15AM -0500, Bill Gatliff wrote:

> It's true that for a specific SoC, you *do* know such things.  So you
> handle that the way the at91 guys have done: you provide a
> at91sam9263_devices.c:at91_add_device_usbh(struct at91_usbh_data *data),
> and _that_ function sets up pins, etc. before it registers the generic
> platform device.  The driver is always a generic platform one, and gets

That does depend on the SoC, at least for the pin muxing - with some
SoCs there's a lot of options for where the signals are brought out so
the pin mux configuration really does need to be board specific.
