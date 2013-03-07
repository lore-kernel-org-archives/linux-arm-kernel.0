From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Mar 2013 15:35:34 +0530
Subject: [PATCH 1/6] platform-drivers: msm: add single-wire serial bus
 interface (SSBI) driver
In-Reply-To: <20130307060117.GA31687@kroah.com>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1362616187-21089-2-git-send-email-davidb@codeaurora.org>
 <20130307013008.GA2910@kroah.com> <8yawqtjvl8y.fsf@huya.qualcomm.com>
 <20130307060117.GA31687@kroah.com>
Message-ID: <5138666E.6090201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/2013 11:31 AM, Greg Kroah-Hartman wrote:
> On Wed, Mar 06, 2013 at 09:20:45PM -0800, David Brown wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>>
>>> On Wed, Mar 06, 2013 at 04:29:42PM -0800, David Brown wrote:
>>>> +menu "Qualcomm MSM SSBI bus support"
>>>> +	depends on ARCH_MSM
>>>
>>> Why?
>>
>> In the sense that ARCH_MSM are the only devices that ever were, or ever
>> will be made with this device.  It doesn't strictly depend on it, but do
>> we want to clutter the config for everything else.
> 
> It's not "clutter".  You want me to build this on other platforms, to
> catch api and other types of build breakages.  This is the way for
> almost all Linux drivers.

Not having a depends on helps build coverage, but I have seen
objections to showing up irrelevant configurations to users (of x86 for
example). See one here from Linus for OMAP_OCP2SCP

http://lkml.indiana.edu/hypermail/linux/kernel/1210.0/00785.html

If this case is different, I am not sure why.

Thanks,
Sekhar
