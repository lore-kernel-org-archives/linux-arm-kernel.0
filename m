From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Fri, 11 Mar 2016 13:12:03 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <56DD7172.4000707@suse.de>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DD7172.4000707@suse.de>
Message-ID: <CAOf5uwkzYBuRty7UfAOwZaAeqYqFboR=yvu7izh9vRw7e+RE5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, Mar 7, 2016 at 1:17 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 06.03.2016 um 20:53 schrieb Andreas F?rber:
>> On next-20160304 the GMAC seems to have regressed, it no longer finds the PHY:
>>
>> libphy: PHY stmmac-0:ffffffff not found
>> eth0: Could not attach to PHY
>> stmmac_open: Cannot attach to PHY (error: -19)
>
> Still with us in next-20160307. CC'ing stmmac maintainers.
>

        tx_delay = <0x30>;
        rx_delay = <0x10>;
        status = "ok";
+       mdio0 {
+               #address-cells = <1>;
+               #size-cells = <0>;
+               compatible = "snps,dwmac-mdio";
+               ethphy0: ethernet-phy at 0 {
+               };
+       };

This is sufficient to get it in the rk3288 firefly

git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next

Michael

> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/net/ethernet/stmicro
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
