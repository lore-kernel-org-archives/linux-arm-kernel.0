From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 8 Feb 2017 18:36:28 -0500
Subject: [PATCH for-4.11 1/2] Revert "phy: Add USB3 PHY support for
 Broadcom NSP SoC"
In-Reply-To: <82b47a03-c41b-378b-2d7c-f263eff514a9@gmail.com>
References: <20170208233023.31922-1-zajec5@gmail.com>
 <82b47a03-c41b-378b-2d7c-f263eff514a9@gmail.com>
Message-ID: <CAC3K-4pT62VQ10MVtrrwbRUr9EYkoudZ0vatN_h9gQa7rxkuqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 6:32 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 02/08/2017 03:30 PM, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> This reverts commit d7bc1a7d41bf ("phy: Add USB3 PHY support for
>> Broadcom NSP SoC") as we already have driver for this PHY (shared by NS
>> and NSP). It was added in commit e5666281d9ea ("phy: bcm-ns-usb3: new
>> driver for USB 3.0 PHY on Northstar").
>>
>> Instead of adding separated driver & duplicating code we should work on
>> improving existing (old) one. Thanks to work done by Broadcom we know
>> there is MDIO bus we weren't aware of & we know register names which
>> makes initialization more clear. This is very valuable info and we
>> should work on using it in existing driver afterwards.
>
> Should not we first extend the old driver to support NSP and then revert
> d7bc1a7d41bf ("phy: Add USB3 PHY support for Broadcom NSP SoC")?

I am currently in the process of doing this, but I'm guessing that I
am 1-2 weeks away from having it completed.  It might not hit the
merge window.

Thanks,
Jon

> --
> Florian
