From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 26 Jul 2018 20:47:34 +0800
Subject: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to
 rebase on M2 Ultra
In-Reply-To: <20180726124119.dwne2sncws2p3sdi@flea>
References: <20180724163655.61365-1-icenowy@aosc.io>
 <20180726124119.dwne2sncws2p3sdi@flea>
Message-ID: <BA51039A-02DD-42C2-A7A9-E1B866074CA6@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?26? GMT+08:00 ??8:41:19, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
>> Banana Pi designs the BPi M2 Berry board to be software compatible
>with
>> BPi M2 Ultra,
>
>Do you have a reference for this?

See [1], it says "BPI-M2U and BPI-M2 Berry share the same image".

[1] http://www.banana-pi.org/download.html

>
>> so it's based on M2 Ultra with some function cuts, including:
>> 
>> - 2048MiB DRAM -> 1024MiB (this should be proceed by the bootloader);
>> - dropped a LED;
>> - dropped eMMC;
>> - dropped USB2 and connect USB1 to a 4-port HUB.
>
>Is it the exhaustive list?

Sorry, but I forgot one thing -- LiPo battery connector.

The list can be examined with [2], except LED difference.

[2] https://bananapi.gitbooks.io/bpi-m2-ultra-open-source-single-board-computer/content/

>
>I'm a bit reluctant to merge that kind of patches usually, since that
>would also imply that each time someone will commit something to the
>M2-Ultra, it would automatically apply to the M2-Berry, without any
>easy way to tell and / or test.
>
>Maxime
