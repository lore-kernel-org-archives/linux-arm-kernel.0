From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 10 May 2017 00:35:23 +0200
Subject: [PATCH 2/4] arm64: dts: rk3399: add power domain for some
 peripheral
In-Reply-To: <1580550.DrIeisNgS3@phil>
References: <1491981044-24635-1-git-send-email-kever.yang@rock-chips.com>
 <1491981044-24635-2-git-send-email-kever.yang@rock-chips.com>
 <1580550.DrIeisNgS3@phil>
Message-ID: <106742786.ILvbsPBJ6D@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 9. Mai 2017, 23:40:29 CEST schrieb Heiko Stuebner:
> Am Mittwoch, 12. April 2017, 15:10:42 CEST schrieb Kever Yang:
> > Add power domain for sd, usb, edp.
> > 
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> 
> applied for 4.13

and dropped again.

Actual testing revealed that I now get "synchronous external aborts" with
this patch applied.

The power-domain driver now probably disables some domain that should've 
stayed on and I guess the only thing missing is probably some power-domains
reference in some device node in rk3399.dtsi.

It would be cool, if you could investigate which one it is :-) .


Heiko
