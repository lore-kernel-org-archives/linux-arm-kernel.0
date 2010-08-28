From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 Aug 2010 18:35:16 -0700
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <20100825144040.GI2153@osiris.boeblingen.de.ibm.com>
References: <4C61EE55.5030506@codeaurora.org>	<201008251414.16411.arnd@arndb.de>	<20100825125451.GH2153@osiris.boeblingen.de.ibm.com>	<201008251555.53653.arnd@arndb.de>
	<20100825144040.GI2153@osiris.boeblingen.de.ibm.com>
Message-ID: <4C7867D4.10404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2010 07:40 AM, Heiko Carstens wrote:
> On Wed, Aug 25, 2010 at 03:55:53PM +0200, Arnd Bergmann wrote:
>>
>> If you don't want to see the warnings, then just remove the strict checks.
>> We already concluded that there is little value in them on s390 since it only
>> shows false postives.
>>
>> Maybe the easiest way would be to rename the option on s390 and move all
>> the other ones into a common place.
> 
> Yes, feel free to do that.
> 

Can you put up the false positives somewhere? I don't have easy access
to an s390 toolchain to test build with and I'm interested to see how
bad the false positives are.

I'm slightly concerned that we'll just have this problem again when
another arch comes along with false positives. But ignoring that issue
is probably fine. I'll respin with a patch to move s390 to something
like DEBUG_WARN_USER_COPY_CHECKS.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
