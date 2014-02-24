From: davem@davemloft.net (David Miller)
Date: Mon, 24 Feb 2014 18:05:10 -0500 (EST)
Subject: [PATCH] net: phy: add suspend_halted module param
In-Reply-To: <CAGVrzcadYTYQEvPxqdMf2f741y5sAgnOYm3EC=f7SOkr8SK2WQ@mail.gmail.com>
References: <1393174719-20806-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CAGVrzcadYTYQEvPxqdMf2f741y5sAgnOYm3EC=f7SOkr8SK2WQ@mail.gmail.com>
Message-ID: <20140224.180510.103916219115440711.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 24 Feb 2014 10:20:10 -0800

> Hi Sebastian,
> 
> 2014-02-23 8:58 GMT-08:00 Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com>:
>> commit 1211ce53077164e0d34641d0ca5fb4d4a7574498
>>   ("net: phy: resume/suspend PHYs on attach/detach")
>> introduced a feature to suspend PHYs when entering halted state.
>>
>> Unfortunately, not all bootloaders properly power-up PHYs on reset
>> and fail to access ethernet because the PHY is still powered down.
>>
>> Therefore, we add a boolean module parameter suspend_halted with
>> default value of true. Disabling that parameter prevents PHYs from
>> being suspended when entering halted state.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Reported-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>> Andrew, can you please re-test if disabling the feature does work on
>> your board? I tried a bunch of mine, but none failed to power-up the
>> PHY in u-boot.
> 
> Would be good to get Andrew's testing on this just to make sure it
> solves his problem. Otherwise:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

I disagree with using a module parameter for this.

Figure out the devices that cannot do this properly, and add
an internal flag that this driver sets.

Module parameters are terrible.
