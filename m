From: van.freenix@gmail.com (Peng Fan)
Date: Tue, 19 Aug 2014 16:12:23 +0800
Subject: [PATCH] arm: Do not overwrite __machine_arch_type
In-Reply-To: <20140819074344.GA30401@n2100.arm.linux.org.uk>
References: <1408418491-29330-1-git-send-email-van.freenix@gmail.com>
 <20140819074344.GA30401@n2100.arm.linux.org.uk>
Message-ID: <53F306E7.8020701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/19/2014 03:43 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 19, 2014 at 11:21:31AM +0800, Peng Fan wrote:
>> If using DT_MACHINE_START when enabled CONFIG_OF, the nr of mdesc is ~0.
>> The value of __machine_arch_type is passsed from bootloader using reigster
>> r1, and assigned in head-common.S. Remove this line to avoid overwrite it.
> 
> No.  The idea here is that the machine_is_xxx() methods are not used when
> using DT, so this disables them.
> 
Got it. Thanks.

Regards,
Peng.
