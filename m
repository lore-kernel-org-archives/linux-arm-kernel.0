From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 12 Mar 2015 13:58:58 +0000
Subject: [PATCH v2 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
In-Reply-To: <20150312134921.GR8656@n2100.arm.linux.org.uk>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-11-git-send-email-andre.przywara@arm.com>
 <20150312105210.GK8656@n2100.arm.linux.org.uk> <550197F5.1020107@arm.com>
 <20150312134921.GR8656@n2100.arm.linux.org.uk>
Message-ID: <55019BA2.1090404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/15 13:49, Russell King - ARM Linux wrote:
> On Thu, Mar 12, 2015 at 01:43:17PM +0000, Andre Przywara wrote:
>> Hi Russel,
>>
>> thanks a lot for looking at the patches!
>>
>> On 12/03/15 10:52, Russell King - ARM Linux wrote:
>>> On Wed, Mar 04, 2015 at 05:59:54PM +0000, Andre Przywara wrote:
>>>> +module_platform_driver(arm_sbsa_uart_platform_driver);
>>>
>>> No need to open code the initialisation, rather than using the
>>> module_*_driver() helper macros to avoid the problem which Dave mentioned.
>>>
>>> These macros are only there to avoid having to write out the same boiler
>>> plate in loads of simple drivers.  As soon as a driver has more than one
>>> device driver structure in it, it needs to be open coded.
>>
>> Actually I prepared this already for the ACPI guys, which want to stuff
>> their ACPI table match function in there - I think then we need the open
>> coded version. So if you don't mind too much, I'd like to keep it like
>> this and hope for someone to actually use it ;-)
> 
> Either your statement is ambiguous, or I'm not understanding you.
> 
> You can't "keep it like this" where "this" is the above code.  The
> above will fail if the driver is built as a module, and cause a build
> time error.  That is not acceptable.

Oh, you are right, I was forgetting about that one, sorry.
I meant I'd rather leave it open coded, but of course I will fix the
module issue.

Cheers,
Andre.
