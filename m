From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 11:18:38 +0200
Subject: [PATCH v3 1/9] gpio: mvebu: fix regmap_update_bits usage
In-Reply-To: <9a098130daa8daeef89fd6c1e80d982699d5c175.1497281623.git-series.gregory.clement@free-electrons.com>
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <9a098130daa8daeef89fd6c1e80d982699d5c175.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdZ2LuT50EMMOuT_FO0pz0nmO_fWhoBJd+Q76STWOpPNFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 5:34 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> In some place in the driver regmap_update_bits was misused. Indeed the
> last argument is not the value of the bit (or group of bits) itself but
> the mask value inside the register.
>
> So when setting the bit N, then the value must be BIT(N) and not 1.
>
> CC: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
> CC: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Already applied this patch, sorry for missing the resend in the series.

Yours,
Linus Walleij
