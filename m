From: joel@jms.id.au (Joel Stanley)
Date: Thu, 3 Nov 2016 00:26:04 +1030
Subject: [PATCH 1/3] ipmi/bt-bmc: change compatible node to 'aspeed,
 ast2400-ibt-bmc'
In-Reply-To: <201611021415.51081.arnd@arndb.de>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <1478073426-3714-2-git-send-email-clg@kaod.org>
 <201611021415.51081.arnd@arndb.de>
Message-ID: <CACPK8XcM1_xmmUu-cCZrSR67Y_qeXuSJ4Xmd_2gcgDT321LdBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 2, 2016 at 11:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 02 November 2016, C?dric Le Goater wrote:
>> The Aspeed SoCs have two BT interfaces : one is IPMI compliant and the
>> other is H8S/2168 compliant.
>>
>> The current ipmi/bt-bmc driver implements the IPMI version and we
>> should reflect its nature in the compatible node name using
>> 'aspeed,ast2400-ibt-bmc' instead of 'aspeed,ast2400-bt-bmc'. The
>> latter should be used for a H8S interface driver if it is implemented
>> one day.
>>
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>
> We generally try to avoid changing the compatible strings after the
> fact, but it's probably ok in this case.
>
> I don't understand who decides which of the two interfaces is used:
> is it the same register set that can be driven by either one or the
> other driver, or do you expect to have two drivers that can both
> be active in the same system and talk to different hardware once
> you get there?

It's the second case. The H8S BT has a different register layout so it
would require a different driver.

We don't yet have a driver for the other BT device, but there was
recent talk of using it as an alternate (non-ipmi channel) between the
BMC and the host. Before that discussion I wasn't aware that the H8S
BT existed. I suggested we fix this up before it hits a final release.

C?dric, do you think ast2400-ibt-bmc or ast2400-ipmi-bt-bmc does a
better job of describing the hardware here?

While we're modifying the binding, should we add a compat string for
the ast2500?

Cheers,

Joel

>
> If the first one of these is true, it seems a little awkward to
> use the DT compatible string to decide which driver to use rather
> than making the decision in the OS.
>
>         Arnd
