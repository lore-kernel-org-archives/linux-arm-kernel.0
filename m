From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Oct 2015 19:44:18 +0530
Subject: [PATCH v1 0/2] Common SerDes driver for TI's Keystone Platforms
In-Reply-To: <20151016080222.GH32532@n2100.arm.linux.org.uk>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
 <20151015165105.GE32532@n2100.arm.linux.org.uk>
 <CAL_JsqJTjCT8D-3OryFPEF8nnaPtrai7Mvf-gJRkh60aDixx-g@mail.gmail.com>
 <20151016080222.GH32532@n2100.arm.linux.org.uk>
Message-ID: <5621063A.2050905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 16 October 2015 01:32 PM, Russell King - ARM Linux wrote:
> On Thu, Oct 15, 2015 at 08:00:41PM -0500, Rob Herring wrote:
>> On Thu, Oct 15, 2015 at 11:51 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Thu, Oct 15, 2015 at 10:25:43AM -0400, WingMan Kwok wrote:
>>>> On TI's Keystone platforms, several peripherals such as the
>>>> gbe ethernet switch, 10gbe ethether switch and PCIe controller
>>>> require the use of a SerDes for converting SoC parallel data into
>>>> serialized data that can be output over a high-speed electrical
>>>> interface, and also converting high-speed serial input data
>>>> into parallel data that can be processed by the SoC.  The
>>>> SerDeses used by those peripherals, though they may be different,
>>>> are largely similar in functionality and setup.
>>>
>>> Given that serdes is not specific to TI, should this be specific to
>>> TI, or should there be an effort to come up with something which
>>> everyone who has serdes links can make use of?
>>>
>>> Serdes comes in multiple different forms: PCIe, 1G SGMII ethernet,
>>> 1000base-X ethernet, 10g ethernet, SATA... I'd hate to see a
>>> plethora of SoC specific stuff for this.
>>
>> The licensed IP I've seen doesn't provide a standard register
>> interface, but just signals to the IP block. Same with PLL IP. So
>> we'll probably get to see vendors continue to differentiate on PHY
>> register design. :)
> 
> So what?  Network drivers differ radically in register design, yet we
> still have a standardised interface to network drivers.
> 
The PHY framework (in drivers/phy/) already provides a standard
interface to be used by the controller drivers no?

Thanks
Kishon
