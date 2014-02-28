From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 12:58:13 +0100
Subject: [PATCH V7 07/10] SPEAr13XX: dts: Add PCIe node information
In-Reply-To: <b02c2cf599817a852e0cdb2e24e76e74da02637d.1393568715.git.mohit.kumar@st.com>
References: <cover.1393568715.git.mohit.kumar@st.com>
 <b02c2cf599817a852e0cdb2e24e76e74da02637d.1393568715.git.mohit.kumar@st.com>
Message-ID: <7430033.eK9aHCDe8b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 17:25:00 Mohit Kumar wrote:
> +                       interrupts = <0 68 0x4>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0x0 0 &gic 68>;
> 

>From the discussion we just had on the imx version of this driver, I suspect
what you want instead is to drop the interrupts property and fix the interrupt
map to be

interrupt-map = <0x0 0 &gic 0 68 0x4>;

	Arnd
