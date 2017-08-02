From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 11:46:57 +0800
Subject: [PATCH v2 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <69ad9443-ff65-8e49-df68-7e5e6c812d45@rock-chips.com>
References: <1501160156-30328-1-git-send-email-david.wu@rock-chips.com>
 <1501160540-30662-1-git-send-email-david.wu@rock-chips.com>
 <20170727134834.GD18666@lunn.ch>
 <65ae1747-4dff-b1d8-8aa3-684fc8c7809a@gmail.com>
 <69ad9443-ff65-8e49-df68-7e5e6c812d45@rock-chips.com>
Message-ID: <CAGb2v6766-8Cn0ZESo9Z0zU4yWR7Tt3+u0gdcd0LccYqLWW+3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David, Florian, Andrew

(resent in plain text)

On Fri, Jul 28, 2017 at 2:56 PM, David.Wu <david.wu@rock-chips.com> wrote:
>
> Hi Florian,
>
> ? 2017/7/28 0:54, Florian Fainelli ??:
>>
>> - if you need knowledge about this PHY connection type prior to binding
>> the PHY device and its driver (that is, before of_phy_connect()) we
>> could add a boolean property e.g: "phy-is-internal" that allows us to
>> know that, or we can have a new phy-mode value, e.g: "internal-rmii"
>> which describes that, either way would probably be fine, but the former
>> scales better
>>
>
> Using "phy-is-internal" is very helpful, but it is easy to confuse with
> the real internal PHY, may we use the other words like phy is inlined.

If "internal" is confusing, would "phy-is-integrated" in the MAC node work?

Either way we would like to have a definitive solution to this. Our
dwmac-sun8i driver is already in v4.13-rc1, with a somewhat flaky
method of knowing whether the internal PHY is used (phy-mode = "mii").

We really want a fix for this release, otherwise we would be force
to revert either the internal PHY part or the whole driver.

ChenYu

>
>> Then again, using phy-mode = "internal" even though this is Reduced MII
>> is not big of a deal IMHO as long as there is no loss of information and
>> that internal de-facto means internal reduced MII for instance.
>> --
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
