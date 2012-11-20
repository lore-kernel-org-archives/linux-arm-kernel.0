From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Nov 2012 14:50:16 +0100
Subject: [PATCH 3/3] ARM: dts: cfa10049: Add PCA9555 GPIO expander to
 the device tree
In-Reply-To: <20121120132546.GA4882@S2100-06.ap.freescale.net>
References: <1352394113-19513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1352394113-19513-4-git-send-email-maxime.ripard@free-electrons.com>
 <20121120132546.GA4882@S2100-06.ap.freescale.net>
Message-ID: <50AB8A98.1060601@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Shawn,

Le 20/11/2012 14:25, Shawn Guo a ?crit :
> On Thu, Nov 08, 2012 at 06:01:53PM +0100, Maxime Ripard wrote:
>> Add the GPIO expander found on the i2c1 bus, behind the muxer to
>> the device tree.
>> 
>> This gpio expander will be used to get tachymeters values and
>> data ready interruptions from the nuvoton NAU7802 ADCs.
>> 
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com> 
>> --- arch/arm/boot/dts/imx28-cfa10049.dts |   26
>> +++++++++++++++++++++++++- 1 file changed, 25 insertions(+), 1
>> deletion(-)
>> 
>> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts
>> b/arch/arm/boot/dts/imx28-cfa10049.dts index bdc80a4..714953b
>> 100644 --- a/arch/arm/boot/dts/imx28-cfa10049.dts +++
>> b/arch/arm/boot/dts/imx28-cfa10049.dts @@ -22,8 +22,9 @@ 
>> apb at 80000000 { apbh at 80000000 { pinctrl at 80018000 { -
>> pinctrl-names = "default", "default"; +				pinctrl-names =
>> "default", "default", "default"; pinctrl-1 =
>> <&hog_pins_cfa10049>; +				pinctrl-2 =
>> <&hog_pins_cfa10049_pullup>;
> 
> I do not think it necessarily needs to be multiple pinctrl states. 
> Something like the following should just work?
> 
> pinctrl-names = "default"; pinctrl-0 = <&hog_pins_cfa10049 
> &hog_pins_cfa10049_pullup>;

Actually, pinctrl-0 is already used by the cfa-10036, and putting also
the group hog_pins_cfa10036 in here would lead to duplication and
confusion imho, thus why I used two different states at first.

Moreover, the cfa-10036 being able to run without any expansion board,
we need to be able to have a different muxing for both.

Apart from that, I guess we could extend the pintctrl-1 property
already here to add the _pullup group.

Maxime


- -- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCriogACgkQGxsu9jQV9nas/ACfbXg9AUF17pzJls/1Sx+ldK2C
JZIAn3pHsCx4BJFQOpV4OJnG5KhuPXMw
=YGhN
-----END PGP SIGNATURE-----
