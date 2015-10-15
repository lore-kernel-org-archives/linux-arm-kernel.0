From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Oct 2015 00:51:58 +0530
Subject: [PATCH v1 0/2] Common SerDes driver for TI's Keystone Platforms
In-Reply-To: <20151015165105.GE32532@n2100.arm.linux.org.uk>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
 <20151015165105.GE32532@n2100.arm.linux.org.uk>
Message-ID: <561FFCD6.7000509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 15 October 2015 10:21 PM, Russell King - ARM Linux wrote:
> On Thu, Oct 15, 2015 at 10:25:43AM -0400, WingMan Kwok wrote:
>> On TI's Keystone platforms, several peripherals such as the
>> gbe ethernet switch, 10gbe ethether switch and PCIe controller
>> require the use of a SerDes for converting SoC parallel data into
>> serialized data that can be output over a high-speed electrical
>> interface, and also converting high-speed serial input data
>> into parallel data that can be processed by the SoC.  The
>> SerDeses used by those peripherals, though they may be different,
>> are largely similar in functionality and setup.
> 
> Given that serdes is not specific to TI, should this be specific to
> TI, or should there be an effort to come up with something which
> everyone who has serdes links can make use of?
> 
> Serdes comes in multiple different forms: PCIe, 1G SGMII ethernet,
> 1000base-X ethernet, 10g ethernet, SATA... I'd hate to see a
> plethora of SoC specific stuff for this.

Generally every SoC use it's own serdes and the programming required is
different for different SoCs. Each of them have their own register map
and clock programming/regulator programming/reset programming are all
different.

However most SoC vendors use the same PHY/SerDes IP to be used by
multiple controllers like PCIe/SATA/USB in a single SoC and a single PHY
driver is used for programming all these PHYs.

Thanks
Kishon

> 
> When serdes is combined with SFP cages, the situation becomes much
> more fun, because the serdes link then needs to become hotpluggable
> (SFP modules are designed to be hotplugged) which means you have to
> be able to switch between (at least) 1G SGMII and 1000base-X modes,
> and probably 10G mode as well.  There's even a SFP module that has
> a SATA connector on it, though I believe there's no standard for
> that, and it's more a hardware hack.
> 
> I've been working in this area but from the Ethernet side on an
> Armada 38x based board which has a SFP cage on it, though it's
> slightly simpler there because there is no support (or I believe
> any desire) to reconfigure the serdes lanes between PCI, ethernet
> and SATA - that's all setup and initialised for us by uboot.
> 
