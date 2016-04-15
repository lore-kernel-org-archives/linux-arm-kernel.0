From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 15 Apr 2016 19:58:46 +0200
Subject: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <5710DA28.6010104@rock-chips.com>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <20160414184848.GB2338@katana> <5710DA28.6010104@rock-chips.com>
Message-ID: <20160415175846.GA1533@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The default frequency rate of function clock is 50M Hz, it can match
> F/S mode, but HS mode not. If use default rate 50M to get 1.7M
> scl-frequency rate , we could not get accurately 1.7M frequecy rate.
> The input-clk-rate is more higher, we get more accurately
> scl-frequency rate,  as 200M is a suitable input-clk-rate.
> 
> If 200M was used for F/S mode, it would increase power consumption, so
> add a option that could be configured from DT.

If I understand you correctly, couldn't you use clk_set_rate() depending
on the desired scl frequency which is already described in DT as
clock-frequency?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/4b1078f2/attachment.sig>
