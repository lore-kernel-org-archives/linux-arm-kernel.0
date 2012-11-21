From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 21 Nov 2012 15:17:12 +0000
Subject: [PATCH 1/1 v2] of_spi: add generic binding support to specify cs
 gpio
In-Reply-To: <1353007197-31491-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121115165048.543FE3E194B@localhost>
 <1353007197-31491-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20121121151713.1F8873E0A47@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Nov 2012 20:19:57 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> This will allow to use gpio for chip select with no modification in the
> driver binding
> 
> When use the cs-gpios, the gpio number will be passed via the cs_gpio field
> and the number of chip select will automatically increased with max(hw cs, gpio cs).
> 
> So if for example the controller has 2 CS lines, and the cs-gpios
> property looks like this:
> 
> cs-gpios = <&gpio1 0 0> <0> <&gpio1 1 0> <&gpio1 2 0>;
> 
> Then it should be configured so that num_chipselect = 4 with the
> following mapping:
> 
> cs0 : &gpio1 0 0
> cs1 : native
> cs2 : &gpio1 1 0
> cs3 : &gpio1 2 0
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: spi-devel-general at lists.sourceforge.net
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Applied, thanks.

g.
