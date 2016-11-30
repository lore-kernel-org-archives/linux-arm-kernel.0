From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 29 Nov 2016 17:15:07 -0800
Subject: [PATCH net-next v3 0/4] Fix OdroidC2 Gigabit Tx link issue
In-Reply-To: <20161129.201331.2207317476589573523.davem@davemloft.net>
References: <1480326409-25419-1-git-send-email-jbrunet@baylibre.com>
 <20161129.193853.827524417068912706.davem@davemloft.net>
 <e14a3b0c-dc34-be14-48b3-518a0ad0c080@gmail.com>
 <20161129.201331.2207317476589573523.davem@davemloft.net>
Message-ID: <162595c2-d403-0070-3399-de03c1653065@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2016 05:13 PM, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Tue, 29 Nov 2016 16:43:20 -0800
> 
>> On 11/29/2016 04:38 PM, David Miller wrote:
>>> From: Jerome Brunet <jbrunet@baylibre.com>
>>> Date: Mon, 28 Nov 2016 10:46:45 +0100
>>>
>>>> This patchset fixes an issue with the OdroidC2 board (DWMAC + RTL8211F).
>>>> The platform seems to enter LPI on the Rx path too often while performing
>>>> relatively high TX transfer. This eventually break the link (both Tx and
>>>> Rx), and require to bring the interface down and up again to get the Rx
>>>> path working again.
>>>>
>>>> The root cause of this issue is not fully understood yet but disabling EEE
>>>> advertisement on the PHY prevent this feature to be negotiated.
>>>> With this change, the link is stable and reliable, with the expected
>>>> throughput performance.
>>>>
>>>> The patchset adds options in the generic phy driver to disable EEE
>>>> advertisement, through device tree. The way it is done is very similar
>>>> to the handling of the max-speed property.
>>>
>>> Patches 1-3 applied to net-next, thanks.
>>
>> Meh, there was a v4 submitted shortly after, and I objected to the whole
>> idea of using that kind of Device Tree properties to disable EEE, we can
>> send reverts though..
> 
> Sorry, I lost this in all the discussion, I can revert.

Yeah, I can understand why, these freaking PHYs tend to generate a lot
of noise and discussion...

> 
> Just send me a revert of the entire merge commit
> a152c91889556df17ca6d8ea134fb2cb4ac9f893 with a short
> description of why and I'll apply it.

OK, I will talk with Jerome first to make sure that we are in agreement
with the solution to deploy to fix the OdroidC2 problem first.

Thanks!
-- 
Florian
