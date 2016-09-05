From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Sep 2016 21:31:11 +0200
Subject: [PATCH v2 4/7] dts: sun8i-h3: add UART1-3 to Orange Pi Plus
In-Reply-To: <20160903120932.GA6289@carbon.kippendief.biz>
References: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
 <1472671858-29220-5-git-send-email-jorik@kippendief.biz>
 <20160902070425.GB6313@lukather>
 <20160903120932.GA6289@carbon.kippendief.biz>
Message-ID: <20160905193111.GC4728@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jorik,

On Sat, Sep 03, 2016 at 02:09:32PM +0200, Jorik Jonker wrote:
> On Fri, Sep 02, 2016 at 09:04:25AM +0200, Maxime Ripard wrote:
> >Unfortunately, these pins can be used for other purposes as well, so
> >we cannot make force that decision down to our users.
> 
> Yes, but since the associated peripheral is disabled, the users are free to
> configure other functions/peripherals, right? I mean something like this in
> pseudo-DT:
> 
> /soc/pio: pinctrl at 01c20800/uart1_pins:
>   allwinner,pins = "PG6, PG7";
> /soc/pio: pinctrl at 01c20800/foo0_pins:
>   allwinner,pins = "PG6, PG7";
>   ..
> /soc/uart1: serial at serial@01c28400:
>   pinctrl-0 = <&uart1_pins>;
>   status = "disabled";
> /soc/bar:
>   pinctrl-0 = <&uart1_pins>;
>   status = "disabled";
> 
> Assuming Linux/DT allows this, this would force nothing, only offer choice
> and ease of use.

Hmm, sorry, I went over your patches too quickly...

That's a great compromise I think. Chen-Yu, any opinion on this?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/5dfc6f12/attachment.sig>
