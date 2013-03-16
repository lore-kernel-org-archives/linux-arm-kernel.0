From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 16 Mar 2013 18:55:10 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzVdIG5ldDogQWRkIGRhdmljb20gd2VtYWMgZXRoZXJu?=
 =?UTF-8?B?ZXQgZHJpdmVyIGZvdW5kIG9uIEFsbHdpbm5lciBBMTAgU29DJ3M=?=
In-Reply-To: <1363380605-6577-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1363380605-6577-1-git-send-email-maxime.ripard@free-electrons.com>
 <1363380605-6577-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1363445710.396407038@f286.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Stefan Roese <sr@denx.de>
> 
> The Allwinner A10 has an ethernet controller that is advertised as
> coming from Davicom.
> 
> The exact feature set of this controller is unknown, since there is no
> public documentation for this IP, and this driver is mostly the one
> published by Allwinner that has been heavily cleaned up.
...
> +Example:
> +
> +wemac: ethernet at 01c0b000 {
> +       compatible = "davicom,wemac";
> +       reg = <0x01c0b000 0x1000>;
> +       interrupts = <55>;
> +       allwinner,power-gpios = <&pio 7 19 0>;

I think regulator API is better for use for this.
And gpio-regulator for this case.

---
