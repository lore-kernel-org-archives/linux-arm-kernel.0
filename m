From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 00:16:50 -0600
Subject: [PATCH V1] ARM: dts: tegra: Modify pcie memory space size
In-Reply-To: <C79B248886DD134989C8FF6B096A91AB91CF1615EC@BGMAIL01.nvidia.com>
References: <1371712491-31070-1-git-send-email-jagarwal@nvidia.com>
 <51C32CC7.5010109@wwwdotorg.org>
 <C79B248886DD134989C8FF6B096A91AB91CF1615EC@BGMAIL01.nvidia.com>
Message-ID: <51C3EFD2.7090803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 11:30 PM, Jay Agarwal wrote:
>> On 06/20/2013 01:14 AM, Jay Agarwal wrote:
>>> - decrease non-prefetch memory size to 128 MB
>>> - increase prefetch memory size to 384 MB
>>> - above change is done because most pcie devices
>>>   prefetch memory size requirement is quite higher
>>>   compared to non-prefetch memory space.
>>
>> It's possible this change won't be suitable for all applications. People may
>> simply need to adjust their DT based on what they want to connect.
>> Still, this patch probably biases things in the correct way for now.
>> Longer term, we might want to investigate dynamically sizing the windows
>> in order to support arbitrary attached devices, in much the same way as the
>> Marvell code does/will in order to conserve physical/bus address space for
>> their multiple controllers.
>>
>> However, this change allows me to correctly enumerate a particular GPU I
>> have plugged into my Harmony board, and assign all the BARs, so:
>>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>
> Thierry,
> Could you please integrate this change also to your branch if review is done. Please let me know once it is done.

I'm sure he will, but pinging after less than 24 hours is a little quick.
