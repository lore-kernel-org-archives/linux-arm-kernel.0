From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Dec 2013 13:21:52 +0100
Subject: [linux-sunxi] Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
In-Reply-To: <1743952.noztKtcF2Y@dizzy-6.site>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <2378731.6b9MyH8v8A@dizzy-6.site> <52AE0E87.2040304@redhat.com>
 <1743952.noztKtcF2Y@dizzy-6.site>
Message-ID: <52AEF060.6000405@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/15/2013 10:19 PM, David Lanzend?rfer wrote:
>>> [...]
>>> Do you have something like this in mind? ->
>>> drivers/mmc/host/dw_mmc-exynos.c
>> No, as explained in my previous mail the idmac being shared seemed to be the
>> only 2 things the dw-mmc controller and the sunxi-mmc controller have in
>> common.
> Ok.
>
>> Looking at dw_mmc-exynos.c it still pretty much is the classic dw-mmc
>> controller with some extra bits, where as the sunxi controller is
>> significantly different (which allows us to write a significant simpler
>> driver).
> Do you have an outline for such a driver as you imagine it?
> I'd be interested into some "experiments".
> Maybe you have a repository where you could push a dedicated tree
> for some colaboration on this?

I think that we're miss-communicating a bit here. What I'm trying to say
is that trying to extend the dw_mmc driver to support sunxi is a bad
idea because the sunxi hardware is quite different. And that the
sunxi hardware having autostop allows the existing sunxi-mci driver to
be much simpler then the dw-mmc driver.

IOW the much simpler driver already exists and it is the sunxi-mci
driver.

Regards,

Hans
