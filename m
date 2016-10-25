From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 12:31:14 +0200
Subject: [PATCH/RFT v2 08/17] ARM: davinci: hawk: add full constraints for
 ohci plat boot
In-Reply-To: <522eeb9a-6fb1-88eb-5c58-7ee209a50fc3@ti.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-9-ahaslam@baylibre.com>
 <522eeb9a-6fb1-88eb-5c58-7ee209a50fc3@ti.com>
Message-ID: <CAKXjFTOFG+o=mpbZ4ixkh8nm+oipx8+nbr0FduCPzJVuXOc0RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 12:28 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
>> From: Axel Haslam <ahaslam@baylibre.com>
>>
>> The phy framework requests an optional "phy" regulator. If it does
>> not find one, it returns -EPROBE_DEFER. In the case of non-DT based boot
>> for the omap138-lcdk board, this would prevent the usb11 phy to probe
>> correctly and ohci would not enumerate.
>>
>> By calling "regulator_has_full_constraints", An error would be returned
>
> nit: prefer regulator_has_full_constraints()
>
>> instead of DEFER for the "optional" regulator, and the probe of
>> the phy driver can continue normally without a regulator.
>>
>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>
> Looks good to me. Just drop the "hawk: from subject line since you also
> touch da830 evm. I am not sure what "ohci plat boot" means. How about
> the following:
>
> "ARM: davinci: da8xx: fix OHCI PHY probe for non-DT boot"
>

Will do.

Thanks
Axel.

> Thanks,
> Sekhar
