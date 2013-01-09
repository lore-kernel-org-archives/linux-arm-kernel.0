From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Jan 2013 10:34:49 -0700
Subject: [PATCH v3 0/9] Migrate Tegra to common clock framework
In-Reply-To: <50ED4DA9.3090406@nvidia.com>
References: <1357292453-28418-1-git-send-email-pgaikwad@nvidia.com>
 <50E70FE5.9010001@wwwdotorg.org> <50EB6403.5090300@wwwdotorg.org>
 <50EC1CD3.3070308@nvidia.com> <50EC6A37.4000206@wwwdotorg.org>
 <50EC8947.4080704@wwwdotorg.org> <50ED4DA9.3090406@nvidia.com>
Message-ID: <50EDAA39.3040609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 03:59 AM, Prashant Gaikwad wrote:
> On Wednesday 09 January 2013 02:31 AM, Stephen Warren wrote:
>> On 01/08/2013 11:49 AM, Stephen Warren wrote:
>>> On 01/08/2013 06:19 AM, Prashant Gaikwad wrote:
>>>> On Tuesday 08 January 2013 05:40 AM, Stephen Warren wrote:
>>>>> On 01/04/2013 10:22 AM, Stephen Warren wrote:
>>>>>> On 01/04/2013 02:40 AM, Prashant Gaikwad wrote:
>>>>>>> This patchset does following:
>>>>>>> 1. Decompose single tegra clock structure into multiple clocks.
>>>>>>> 2. Try to use standard clock types supported by common clock
>>>>>>> framework.
>>>>>>> 3. Use dynamic initialization.
>>>>>>> 4. Move all clock code to drivers/clk/tegra from mach-tegra.
>>>>>>> 5. Add device tree support for Tegra20 and Tegra30 clocks.
>>>>>>> 6. Remove all legacy clock code from mach-tegra.
>>>>>> I think there are bugs here. I applied all your clock patches on
>>>>>> top of
>>>>>> Tegra's for-next (see list below), and found that the following don't
>>>>>> work on Springbank:
>>>>>>
>>>>>> * HDMI display
>>>>>> * Audio playback
>>>>>> * WiFi
>>>>> (BTW, I stopped Cc'ing linux-kernel@, but added linux-tegra@
>>>>> instead...)
>>>>>
>>>>> Prashant, some updated testing results based off the "dev/ccf" branch
>>>>> you sent me on our internal git server:
>>> ...
>>>> I have updated the internal branch with all the above mentioned fixes.
>> ...
>>> The remaining item is the display issue on Tegra30, which I'll go look
>>> at now.
>> The USB3 clock, which isn't used by any drivers on Tegra30, and hence
>> was disabled at boot, was set up incorrectly and ended up mapping to the
>> disp1 clock, and hence turned off the display. The following fixes it:
> 
> Stephen, thanks for the fix!! I have included this and PLLE fix; updated
> internal branch.

Almost everything works great now.

However, I don't see any fix for the PLLE issue in the code; if there is
one it certainly doesn't work. Applying my previous hack makes it work.

FYI, the branch I tested with is at
git://nv-tegra.nvidia.com/user/swarren/linux-2.6 test-ccf-rework-2

It's rebased onto the latest Tegra for-next.
