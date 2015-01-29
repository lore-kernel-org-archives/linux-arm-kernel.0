From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 29 Jan 2015 11:34:26 -0500
Subject: [PATCH v10 2/2] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <20150129160553.GC26493@n2100.arm.linux.org.uk>
References: <sc9836-serial-v10>
 <1422443324-25082-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1422443324-25082-3-git-send-email-chunyan.zhang@spreadtrum.com>
 <54CA5128.8050500@gmail.com> <54CA568E.6080306@hurleysoftware.com>
 <20150129160553.GC26493@n2100.arm.linux.org.uk>
Message-ID: <54CA6112.9020805@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2015 11:05 AM, Russell King - ARM Linux wrote:
> On Thu, Jan 29, 2015 at 10:49:34AM -0500, Peter Hurley wrote:
>> Hi Varka,
>>
>> On 01/29/2015 10:26 AM, Varka Bhadram wrote:
>>> This check is not required. It will be done by devm_ioremap_resource()
>>
>> I disagree. devm_ioremap_resource() interprets the NULL resource as
>> a bad parameter and returns -EINVAL which is then forwarded as the
>> return value from the probe.
>>
>> -ENODEV is the correct return value from the probe if the expected
>> resource is not available (either because it doesn't exist or was already
>> claimed by another driver).
> 
> (Adding Thierry as the author of this function.)
> 
> I believe devm_ioremap_resource() was explicitly designed to remove such
> error handling from drivers, and to give drivers a unified error response
> to such things as missing resources.
> 
> See the comments for this function in lib/devres.c.

Maybe the purpose would be better served by wrapping the idiom in a single
function.

Regards,
Peter Hurley
