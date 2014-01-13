From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 13 Jan 2014 13:13:52 +0100
Subject: [PATCH RFC 06/10] ARM: s3c64xx: pm: Add device tree based power
 domain instantiation
In-Reply-To: <20140113110935.GB29039@sirena.org.uk>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-7-git-send-email-tomasz.figa@gmail.com>
 <20140112192910.GW29039@sirena.org.uk> <52D2EE32.5060709@gmail.com>
 <20140113110935.GB29039@sirena.org.uk>
Message-ID: <52D3D880.2090300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.01.2014 12:09, Mark Brown wrote:
> On Sun, Jan 12, 2014 at 08:34:10PM +0100, Tomasz Figa wrote:
>> On 12.01.2014 20:29, Mark Brown wrote:
>>> On Sat, Jan 11, 2014 at 08:42:48PM +0100, Tomasz Figa wrote:
>
>>>> This patch adds support for registering power domains of S3C64xx SoCs
>>>> and binding devices to them using device tree.
>
>>>> +#ifdef CONFIG_OF
>>>> +static struct of_device_id s3c64xx_pd_matches[] = {
>>>> +	{ .compatible = "samsung,s3c6400-clock", },
>>>> +	{ .compatible = "samsung,s3c6410-clock", },
>>>> +	{ },
>>>>   };
>
>>> Looks like a rebasing issue?  Otherwise this looks nice.
>
>> Hmm, what's the problem here? Maybe I'm just blind, but I fail to
>> see anything wrong (except that the array should be const...).
>
>> Thanks for reviewing this.
>
> I wasn't expecting to see references to clocks come up in power domain
> code.
>

Power domain control registers are part of the system controller block, 
which uses the "samsung,s3c64*-clock" compatible string. I know this is 
a bit unfortunate, but all registers of this IP block are mapped at the 
same page and some clock registers are at the other end of this area 
than others, so there is even no good way to split them into separate 
mappings.

Best regards,
Tomasz
