From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Thu, 21 Nov 2013 09:05:28 +0100
Subject: [PATCHv9][ 3/3] ARM: dts: cpuimx35 Add touchscreen support.
In-Reply-To: <20131121050922.GF18477@ns203013.ovh.net>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
 <1383916659-9988-3-git-send-email-denis@eukrea.com>
 <20131121050922.GF18477@ns203013.ovh.net>
Message-ID: <20131121090528.41af72bd@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Thu, 21 Nov 2013 06:09:22 +0100,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :
> > +	tsc2007: tsc2007 at 48 {
> > +		compatible = "ti,tsc2007";
> > +		reg = <0x48>;
> > +		interrupt-parent = <&gpio3>;
> > +		interrupts = <0x2 0x8>;
> > +		gpios = <&gpio3 2 1>;
> as explain on the binding drop this gpios this is an IRQ not a gpio
> 
> NACK
> 
please read the tsc2007's code, in the patch there is :

+static int tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
+{
+       return !gpio_get_value(ts->gpio);
+}
+

http://www.mail-archive.com/linux-input at vger.kernel.org/msg06765.html

Eric
