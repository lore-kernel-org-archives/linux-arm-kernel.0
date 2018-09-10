From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 14:42:36 +0200
Subject: Rockchip RV1108 mainline kernel support
In-Reply-To: <CAAPZna3aGkUmDeAwM4J6LpeC9m1VA=CUQN_ChiwvTLkaE2zdrw@mail.gmail.com>
References: <CAAPZna3aGkUmDeAwM4J6LpeC9m1VA=CUQN_ChiwvTLkaE2zdrw@mail.gmail.com>
Message-ID: <8240937.RLPrvYGblP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am Donnerstag, 19. Juli 2018, 15:53:02 CEST schrieb Fabio Berton:
> We're adding support to a custom Rockchip RV1108 in mainline kernel.
> 
> Currently this custom board runs fine on the Rockchip 3.10 vendor kernel.
> 
> The main problems is that kernel 4.17 can't detect eMMC.
> 
> I would appreciate any help on how to make the mainline kernel to
> detect eMMC on this board

Maybe you already solved your issue already, I just found your mail in
my inbox again.

So far I haven't gotten any rv1108-based board to do tests on, so it's a
bit hard trying to find problem sources.

On most recent Rockchip boards the (dw-)mmc runs just fine, but in your
log + kernel commandline I noticed that you could try to add the
"rootwait"  commandline option, as at the time of the failing rootfs the
emmc may simply not have finished probing the card yet.


Heiko
