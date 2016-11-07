From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 7 Nov 2016 13:11:25 -0200
Subject: [PATCH] ARM: dts: imx6: Add support for Logic PD SOM and Baseboard
In-Reply-To: <CAHCN7xJ=KK-=5sVu0Or5bep-cdk3hq4+a3gFj-W0bCcVhQyWNw@mail.gmail.com>
References: <1469030786-28424-1-git-send-email-aford173@gmail.com>
 <20160809082400.GR4678@tiger>
 <CAHCN7x+YopHVNxh4Vi5o1d=S3FFkoz45dNmgHMgs1sAQqaL77A@mail.gmail.com>
 <20161105070043.GA5597@dragon>
 <CAHCN7xJ=KK-=5sVu0Or5bep-cdk3hq4+a3gFj-W0bCcVhQyWNw@mail.gmail.com>
Message-ID: <CAOMZO5DOjGAJytMruLT7mZg2BEbNB2FW-Fyo0Xx0tsr-sZ=6Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Mon, Nov 7, 2016 at 1:03 PM, Adam Ford <aford173@gmail.com> wrote:

> I rebased on the 4.9-rc4, and the pinmux errors go away, but the
> regulators appear to need their own container or I get the following
> error:

You can write the regulators without the container as follows:

reg_3p3v: regulator-3p3v {

reg_usb_otg_vbus: regulator-usbotgvbus {
         compatible = "regulator-fixed";
         regulator-name = "usb_otg_vbus";
         regulator-min-microvolt = <5000000>;
         regulator-max-microvolt = <5000000>;
         gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
         enable-active-high;
};
