From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu, 18 Sep 2014 08:46:57 +0200
Subject: [PATCH 4/7] clk: add clk-asm9260 driver
In-Reply-To: <20140917135440.GG27054@piout.net>
References: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
 <1410646408-28901-5-git-send-email-linux@rempel-privat.de>
 <20140917135440.GG27054@piout.net>
Message-ID: <541A7FE1.8060202@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.09.2014 um 15:54 schrieb Alexandre Belloni:
> Hi,
> 
> Please have a look at https://lkml.org/lkml/2014/5/14/598 which describe
> the preferred way of implementing clocks in the CCF where you only
> declare the clock generator in the DT instead of each separate clocks.

hm... if i see it correctly. i will need to move almost everything from
DT to clk-driver. And i will need to create separate driver for other
SoC provided by AlphaScale. On other side with current (generic) driver
i will need only to change DT and it will work.

May be instead of going qcom way, it will be better to have generic
gate, div and mux bindings for DT? Sure it will make DT a bit fuzzy, but
it will dramatically reduce kernel code and reduce the time of providing
code to upstream.

I don't think drivers/clk/qcom/gcc-msm8974.c is less complicated solution.
-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140918/a206d61a/attachment.sig>
