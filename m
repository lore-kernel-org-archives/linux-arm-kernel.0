From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Feb 2014 09:45:53 -0700
Subject: [PATCH v3 3/6] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <20140206091114.GK19389@tbergstrom-lnx.Nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
 <1390952176-30402-4-git-send-email-pdeschrijver@nvidia.com>
 <52F28DE2.1040207@wwwdotorg.org>
 <20140206091114.GK19389@tbergstrom-lnx.Nvidia.com>
Message-ID: <52F3BC41.1030901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2014 02:11 AM, Peter De Schrijver wrote:
> On Wed, Feb 05, 2014 at 08:15:46PM +0100, Stephen Warren wrote:
>> On 01/28/2014 04:36 PM, Peter De Schrijver wrote:
>>> Implement fuse driver for Tegra20, Tegra30, Tegra114 and Tegra124.

>>> diff --git a/Documentation/ABI/testing/sysfs-driver-tegra-fuse b/Documentation/ABI/testing/sysfs-driver-tegra-fuse
>>> +What:		/sys/devices/*/<our-device>/fuse
>>> +Date:		December 2013
>>> +Contact:	Peter De Schrijver <pdeschrijver@nvidia.com>
>>> +Description:	read-only access to the efuses on Tegra20, Tegra30, Tegra114
>>> +		and Tegra124 SoC's from NVIDIA. The efuses contain write once
>>> +		data programmed at the factory.
>>> +Users:		any user space application which wants to read the efuses on
>>> +		Tegra SoC's
>>
>> Surely this file should describe the format of the file, since that's
>> part of the ABI too, right?
>>
> 
> Part of the fuse data is ODM defined so possibly board specific.

I didn't mean the interpretation of which fuses mean what semantically,
but rather the data format of the file. IIRC looking at the code, it's
just a binary dump of the fuses, but it might be worth spelling out that
it's a byte-oriented binary file, with fuse 0 in bit 0 of byte 0 etc.?
