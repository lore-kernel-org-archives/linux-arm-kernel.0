From: rafal@milecki.pl (=?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=)
Date: Thu, 09 Feb 2017 00:39:08 +0100
Subject: [PATCH for-4.11 1/2] Revert "phy: Add USB3 PHY support for
 Broadcom NSP SoC"
In-Reply-To: <82b47a03-c41b-378b-2d7c-f263eff514a9@gmail.com>
References: <20170208233023.31922-1-zajec5@gmail.com>
 <82b47a03-c41b-378b-2d7c-f263eff514a9@gmail.com>
Message-ID: <1b66f9ab3a9efd1bd0817a114e5b9ec9@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-02-09 00:32, Florian Fainelli wrote:
> On 02/08/2017 03:30 PM, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>> 
>> This reverts commit d7bc1a7d41bf ("phy: Add USB3 PHY support for
>> Broadcom NSP SoC") as we already have driver for this PHY (shared by 
>> NS
>> and NSP). It was added in commit e5666281d9ea ("phy: bcm-ns-usb3: new
>> driver for USB 3.0 PHY on Northstar").
>> 
>> Instead of adding separated driver & duplicating code we should work 
>> on
>> improving existing (old) one. Thanks to work done by Broadcom we know
>> there is MDIO bus we weren't aware of & we know register names which
>> makes initialization more clear. This is very valuable info and we
>> should work on using it in existing driver afterwards.
> 
> Should not we first extend the old driver to support NSP and then 
> revert
> d7bc1a7d41bf ("phy: Add USB3 PHY support for Broadcom NSP SoC")?

Sounds like a weird / dirty development method to me: adding duplicated 
code
first then working on cleaning it. Unless you mean drivers/staging/.

We also should never drop support for supported DT bindings, so I really 
think
it's the cleanest to revert it now.

I think Jon was also OK with this solution.
