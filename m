From: monstr@monstr.eu (Michal Simek)
Date: Thu, 20 Jun 2013 17:56:30 +0200
Subject: [PATCH RFC 0/2] Extend multi_v7_defconfig
In-Reply-To: <5ab196fe-de67-4d75-a722-c084517a948a@CO9EHSMHS003.ehs.local>
References: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
 <201306192046.41005.arnd@arndb.de> <51C291D0.6000401@monstr.eu>
 <201306201002.01702.arnd@arndb.de> <51C2BD00.4000800@monstr.eu>
 <5ab196fe-de67-4d75-a722-c084517a948a@CO9EHSMHS003.ehs.local>
Message-ID: <51C3262E.80407@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 05:41 PM, S?ren Brinkmann wrote:
> On Thu, Jun 20, 2013 at 10:27:44AM +0200, Michal Simek wrote:
>> On 06/20/2013 10:02 AM, Arnd Bergmann wrote:
>>> On Thursday 20 June 2013, Michal Simek wrote:
>>>> On 06/19/2013 08:46 PM, Arnd Bergmann wrote:
>>>>> On Wednesday 19 June 2013, Soren Brinkmann wrote:
>>>>>> I don't know how much a defconfig is supposed to provide, hence as RFC.
>>>>>> This patches are needed for booting Zynq into a minimum ramfs based
>>>>>> system with a serial console.
>>>>>
>>>>> In my opinion we should provide enable all the platform specific drivers
>>>>> in the defconfigs, as well as everything needed to boot the system,
>>>>> to get proper compile coverage as well as the ability to test changes
>>>>> easily. Your patches look good. Michal, would you apply them and
>>>>> send another pull request or should I just take them directly?
>>>>
>>>> Soren asked me 2 days ago if make sense to create zynq defconfig or not.
>>>> I just suggested him to better extend this multi_v7_defconfig.
>>>> But still question is if we can/should create zynq specific defconfig?
>>>> Or are you going to remove all of these platform specific defconfig?
>>>
>>> We don't have a consistent policy across platforms at the moment.
>>> Traditionally we had multiple defconfigs per platform, in some cases
>>> one per board, but moving towards one defconfig per platform at
>>> the moment.
>>
>> That's what I though but on the other hand in this process
>> all these defconfigs should be removed.
>>
>>> I guess whether or not to have a separate defconfig for one platform
>>> or to use only multi_*_defconfig is a question of how many people
>>> would use a zynq_defconfig in practice.
>>
>> The point is if you look at zynq users than they will just use this zynq_defconfig
>> because they know that it is for zynq and also they don't want to
>> compile drivers for other platforms which zynq can't use.
>> From distribution point of view they want to use only one image because it is just
>> easier.
>>
>> Based on this if there is an option to also add just zynq defconfig, I would prefer
>> to also add it.
>>
>>>> Definitely agree that multi_v7 defconfig should enable everything needed
>>>> to boot the system.
>>>> Does it also mean that we should also enable all zynq drivers
>>>> to get better compile coverage?
>>>
>>> I would say yes.
>>>
>>> My feeling is that multi_v7_defconfig should enable all hardware
>>> support for the platforms in it, and that users would take it
>>> as a starting point if they want to have a configuration for
>>> an embedded system, disabling everything they don't need.
>>
>> I just wanted to be sure because you wrote just drivers for booting
>> it means any "minimal" configuration to get it boot not all drivers.
>>
>> If you are ok, Soren will prepare also specific zynq defconfig file
>> and check if there are any missing drivers which are not enabled for zynq
>> for multi_v7. I will collect them in one branch and will send pull request.
> I can check. But I don't think it makes too much sense currently. Even
> though multi_v7_defconfig targets several SOCs its pretty minimal. I
> think there are just a few SOC BSPs and serial drivers selected. Due to
> lacking driver support in mainline, a Zynq specific config would not be
> that different, IMHO.
> But this does hopefully change with growing driver support for Zynq in
> mainline.

It depends. Kernel with all possible drivers for all arm multiplatform
could be big and also it will take a lot of time to compile it.

It is more up to Arnd and Olof.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/3ac6c70b/attachment.sig>
