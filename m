From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 16 Sep 2012 11:09:11 +0200
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <20120916074652.GM28177@lunn.ch>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120916074652.GM28177@lunn.ch>
Message-ID: <50559737.8000705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2012 09:46 AM, Andrew Lunn wrote:
>> +Required properties:
>> +- compatible: "marvell,88f6180-pinctrl",
>> +              "marvell,88f6190-pinctrl", "marvell,88f6192-pinctrl",
>> +              "marvell,88f6281-pinctrl", "marvell,88f6282-pinctrl"
>> +
>> +This driver supports all kirkwood variants, i.e. 88f6180, 88f619x, and 88f628
>
> The current MPP code determines for itself what chip it is running on.
> It can then check if a pin configuration is valid for the current
> run time environment.
>
> Here you are suggesting we have to put into the DT what chip we expect
> to be on.
>
> What is the advantage of this, over getting the information from the
> device itself?

Hi Andrew,

there is no advantage over determining the variant on run time except
that it is statically and (normally) known at boot time. I understand
that mass converting kirkwood to pinctrl would require to know all
the different variants.

If there are no objections from the others, I agree to determine the
variant from the existing kirkwood_id(). I was just unsure if it is
ok to use platform-specific code with DT here.

Any ideas how to get kirkwood_id() linked into pinctrl-kirkwood with
the get-rid-of-arch-includes policy?

Sebastian
