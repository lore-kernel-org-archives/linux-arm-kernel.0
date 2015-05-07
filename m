From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 7 May 2015 20:10:15 +0800
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <4412805.fx6caR2qJ7@wuerfel>
References: <55417F5A.4040300@linaro.org> <20501959.OF3FLWO2Eh@wuerfel>
 <554B2DF5.4040600@huawei.com> <4412805.fx6caR2qJ7@wuerfel>
Message-ID: <554B5627.100@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/7 17:43, Arnd Bergmann wrote:
> On Thursday 07 May 2015 17:18:45 Shannon Zhao wrote:
>> > On 2015/5/7 16:55, Arnd Bergmann wrote:
>>> > > On Thursday 07 May 2015 10:39:35 Shannon Zhao wrote:
>>>> > >> I tried Ubuntu Trusty from Christoffer, when typing "system_powerdown"
>>>> > >> on QEMU monitor, "cat /dev/input/event0 | hexdump" shows the event is
>>>> > >> triggered but the guest doesn't poweroff.
>>> > > 
>>> > > Can you try installing acpid by running 'sudo apt-get install acpid' in
>>> > > the image? I suspect it should just work by scanning the event devices
>>> > > even in the absence of ACPI on the platform.
>>> > > 
>> > 
>> > Cool, I start acpid and the poweroff works.
> Ok, great, thanks for confirming this! Have you tried reboot as well?
> 
>>From looking at the acpid source code, I suspect it does not work unless
> extra configuration files are added, but that would be the same as for the
> ACPI case.

I test reboot and it doesn't work for both acpid and systemd.

BTW, IIUC QEMU doesn't support the gracefully reboot support. The reboot
depends on libvirt or other management tools. So the reboot case in
virtualization is firstly poweroff, then start again.

-- 
Shannon
