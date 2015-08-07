From: raghumag@gmail.com (raghu MG)
Date: Sat, 8 Aug 2015 02:24:04 +0530
Subject: Armadaxp GPIO interrupts
In-Reply-To: <CAG1O52XO+5F11ELZ+7txWXTYPwmhQP5sVvcjdCiM_T1+ptfp=w@mail.gmail.com>
References: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
 <20150804153439.GA28673@lunn.ch>
 <CAG1O52W2Gy_6_DfewtUqoK_J+Y=KwVGyygNaPu2xyPM_ZkLfcQ@mail.gmail.com>
 <CAG1O52VQPpeGkA8bqYbPMTiT9Mua1yHi3H3osqJsHqm-RRKzow@mail.gmail.com>
 <20150805162155.GE32760@lunn.ch>
 <CAG1O52WPFfm+XGk01iUVWLu=-Dm7bcDVmhv3P8iQDH+HHjsLUA@mail.gmail.com>
 <20150806132926.GB19896@lunn.ch>
 <CAG1O52XUyPkgTTRKftujZBNK1=n6GBdWgBg_kq6SsC5XMaeU3w@mail.gmail.com>
 <20150806171312.GI13421@lunn.ch>
 <CAG1O52XO+5F11ELZ+7txWXTYPwmhQP5sVvcjdCiM_T1+ptfp=w@mail.gmail.com>
Message-ID: <CAG1O52VTqkiGbQ2Et98WyL_vqAhcx6VXxPmHMpLnSJx5wCLe-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
I added these entries into armada-xp-gp.dtb
 gpio_rtm {
                compatible = "gpio-rtm";
                #address-cells = <1>;
                #size-cells = <0>;
                pinctrl-0 = <&keys_pin>;
                pinctrl-names = "default";

                 rtm at 57 {
                        label = "RTM JACKINOUT";
                        gpios = <&gpio1 26 GPIO_ACTIVE_LOW>; /* GPIO 57 */
                };
        };

So I understand the leaf nodes are specific purpose of
GPIOs(input:keyboard,mouse,touchpad etc).
1)For the board I am working needs different implementation for GPIO
57 unlike input devices drivers driving GPIOs.
2)To implement the functionality I need to write driver specific to my
board which will implement event specific to requirements.
I hope I am going right here, can you name a simple driver(kernel
source) where it would make my driver development easy.

Thanks & Regards
Raghu
