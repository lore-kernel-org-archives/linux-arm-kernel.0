From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Mar 2010 10:37:06 +0000
Subject: QUERY: How to handle SOC Configuration (Peripheral
	Multiplexing) in linux
In-Reply-To: <4B9E0A65.2090103@st.com>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
	<4B9DD3A3.7050106@st.com> <4B9DF2FF.3000706@st.com>
	<4B9DF966.6050504@st.com>
	<1b68c6791003150237k3d1508d3meb8370509dcfc9a8@mail.gmail.com>
	<4B9E0A65.2090103@st.com>
Message-ID: <20100315103705.GA700@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 03:52:29PM +0530, Shiraz HASHIM wrote:
> Actually you have pointed to right thing and this is really important.
> Some architectures (I think ppc) have device tree option to pass the
> hardware configuration to the kernel from bootloader.
> I dont know such option exists for arm. Lets hear others' opinions.

We don't have support for DT yet.

Currently, we handle most of the platform dependencies via machine types
and having individual board support C files provide the necessary device
structures and pin muxing information to core support.
