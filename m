From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 20 Jan 2015 07:58:43 +0100
Subject: [PATCH v1 0/4] net: stmmac: dwmac-rk: Fix phy regulator issues
In-Reply-To: <1446006.BXnWRvK5p3@phil>
References: <1421690889-11901-1-git-send-email-romain.perier@gmail.com>
 <1446006.BXnWRvK5p3@phil>
Message-ID: <CABgxDoLXBvrqt5SnGybWa_EbT_wGjwHj80bLvhAE3og-m-7t6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

2015-01-19 21:19 GMT+01:00 Heiko St?bner <heiko@sntech.de>:
> Hi Romain
>
> Am Montag, 19. Januar 2015, 18:08:05 schrieb Romain Perier:
>> This series fixes few issues in dwmac-rk:
>>
>> 1. Voltage settings was hardcoded into the driver for the phy regulator.
>>    The driver now uses the default voltage settings found in the devicetree,
>> which are applied throught the regulator framework.
>> 2. The regulator name used to power on or power off the phy was put in the
>> devicetree variable "phy_regulator", which is not standard and added a lot
>> of code for nothing. The driver now uses the devicetree property
>> "phy-supply" and the corresponding functions to manipulate this regulator.
>>
>> The corresponding devicetree files are also updated. As, dwmac-rk was
>> recently pushed in the development tree, I don't care about devicetree
>> backward compatibility issues.
>
> This last sentence is slightly misleading :-) .
>

Yes, I meant that I don't need to care about it, as you explain it well below.
Sorry for my misleading sentence ;) . I will fix it in my second serie.

> The actual fact is, that these new bindings for the rk3288 gmac have not been
> released with any official kernel release yet ... i.e. the will be released with
> 3.20 in whatever form, so we don't _need_ to care about keeping compatibility
> still for the next 2.5 weeks or so.
>
> @Dave: it would be good if this series (when fixed) could still go into the
> 3.20 material so we don't get stuck with the non-standard regulator property.
>
>
> As we'll probably need a v2 due to at the issue in patch3, could you also
> switch places of patch1 and 2, which would keep bisecatbility (i.e. regulator
> property before removing the voltage setting from the driver).

This sentence about re-ordering patches is for Dave or for me ?

Thanks,
Romain
