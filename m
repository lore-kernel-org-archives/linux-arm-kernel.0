From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 12 Sep 2012 17:56:38 +0100
Subject: [PATCH 05/11] clk: Versatile Express clock generators ("osc")
 driver
In-Reply-To: <CACRpkdZcUuyKpb3EBrdENGnGgZQjbi15Q+21NkF-pVX_Lw_HFg@mail.gmail.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-6-git-send-email-pawel.moll@arm.com>
 <20120910191420.20289.1923@nucleus>	<1347379848.2497.13.camel@hornet>
 <CACRpkdZcUuyKpb3EBrdENGnGgZQjbi15Q+21NkF-pVX_Lw_HFg@mail.gmail.com>
Message-ID: <1347468998.2497.17.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-11 at 19:00 +0100, Linus Walleij wrote:
> >> > +       osc = kzalloc(sizeof(*osc), GFP_KERNEL);
>
> Can't you just use devm_kzalloc(&vecdev->dev, ...) and be done with it?

Eh. It was devm_kzalloc() initially, then the driver became an "early"
one and I could use devm_*(). I actually made it devm_kzalloc() again,
hope it will survive like this to v2.

Pawe?
