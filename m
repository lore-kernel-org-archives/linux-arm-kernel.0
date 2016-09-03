From: jorik@kippendief.biz (Jorik Jonker)
Date: Sat, 3 Sep 2016 14:09:32 +0200
Subject: [PATCH v2 4/7] dts: sun8i-h3: add UART1-3 to Orange Pi Plus
In-Reply-To: <20160902070425.GB6313@lukather>
References: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
 <1472671858-29220-5-git-send-email-jorik@kippendief.biz>
 <20160902070425.GB6313@lukather>
Message-ID: <20160903120932.GA6289@carbon.kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 09:04:25AM +0200, Maxime Ripard wrote:
>Unfortunately, these pins can be used for other purposes as well, so
>we cannot make force that decision down to our users.

Yes, but since the associated peripheral is disabled, the users are free 
to configure other functions/peripherals, right? I mean something like 
this in pseudo-DT:

 /soc/pio: pinctrl at 01c20800/uart1_pins:
   allwinner,pins = "PG6, PG7";
 /soc/pio: pinctrl at 01c20800/foo0_pins:
   allwinner,pins = "PG6, PG7";
   ..
 /soc/uart1: serial at serial@01c28400:
   pinctrl-0 = <&uart1_pins>;
   status = "disabled";
 /soc/bar:
   pinctrl-0 = <&uart1_pins>;
   status = "disabled";

Assuming Linux/DT allows this, this would force nothing, only offer 
choice and ease of use.

Best,

Jorik
