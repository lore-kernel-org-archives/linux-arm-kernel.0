From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 7 May 2015 17:18:45 +0800
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <20501959.OF3FLWO2Eh@wuerfel>
References: <55417F5A.4040300@linaro.org> <2196079.901rMdSZr0@wuerfel>
 <554AD067.9090707@linaro.org> <20501959.OF3FLWO2Eh@wuerfel>
Message-ID: <554B2DF5.4040600@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/7 16:55, Arnd Bergmann wrote:
> On Thursday 07 May 2015 10:39:35 Shannon Zhao wrote:
>> On 2015/5/6 15:29, Arnd Bergmann wrote:
>>> On Wednesday 06 May 2015 14:56:58 Shannon Zhao wrote:
>>>> On 2015/5/5 19:13, Shannon Zhao wrote:
>>>>
>>>> Jan 01 00:01:02 localhost systemd[1]: Starting Login Service...
>>>> Jan 01 00:01:07 localhost systemd[1]: Started Login Service.
>>>> Jan 01 00:01:07 localhost systemd-logind[927]: Watching system buttons
>>>> on /dev/input/event0 (gpio-keys)
>>>> Jan 01 00:01:07 localhost systemd-logind[927]: New seat seat0.
>>>> Jan 01 00:01:25 localhost systemd-logind[927]: New session c1 of user root.
>>>>
>>>> Visit https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/1347776 for
>>>> details.
>>>
>>> How about Ubuntu or Debian releases that do not use systemd?
>>>
>>> I guess we should check with a Debian Wheezy or Ubuntu Trusty release.
>>> My guess is that it will work fine, but some minor adjustment might
>>> be needed.
>>>
>>
>> Hi Arnd,
>>
>> If the Debian Wheezy or Ubuntu Trusty release doesn't use systemd, what
>> user space process do they use to handle the input device event?
> 
> I don't really know, there are probably multiple tools available, but
> they might not be installed by default
>  
>> I tried Ubuntu Trusty from Christoffer, when typing "system_powerdown"
>> on QEMU monitor, "cat /dev/input/event0 | hexdump" shows the event is
>> triggered but the guest doesn't poweroff.
> 
> Can you try installing acpid by running 'sudo apt-get install acpid' in
> the image? I suspect it should just work by scanning the event devices
> even in the absence of ACPI on the platform.
> 

Cool, I start acpid and the poweroff works.

-- 
Shannon
