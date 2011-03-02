From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 01 Mar 2011 17:39:19 -0800
Subject: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
In-Reply-To: <4D6D9D06.2020204@bluewatersys.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>	<20110216115729.GA29817@besouro.research.nokia.com>	<4D6B78BF.1020102@stericsson.com>	<4D6C7B56.9060109@codeaurora.org>
	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>
	<4D6D9B10.9000606@codeaurora.org>
	<4D6D9D06.2020204@bluewatersys.com>
Message-ID: <4D6D9FC7.1090206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2011 05:27 PM, Ryan Mallon wrote:
> On 03/02/2011 02:19 PM, Saravana Kannan wrote:
>> On 03/01/2011 05:13 PM, Andrei Warkentin wrote:
>>> On Mon, Feb 28, 2011 at 10:51 PM, Saravana Kannan
>>> <skannan@codeaurora.org>   wrote:
>
> <snip>
>
>>> What would an "arch" file mean? The name of the soc platform?
>>
>> The arch file would pretty much be the "xxxx" from arch/arm/mach-xxxx or
>> similar paths. If that info is already available elsewhere, then that
>> file is not needed. I proposed using the arch since that will remove the
>> need to maintain some database of unique/reserved names/numbers for each
>> implementation of socinfo (like the machinetypes list we have).
>
> /proc/cpuinfo already tells you what the CPU is, which gives more
> information than just the architecture name.
>
> Why is the arch information even required by userspace?

The socinfo exported by each soc is different. If userspace is trying to 
make decisions based on socinfo, it will need to know what type of soc 
(really what type of socinfo implementation) it is before trying to 
interpret the rest of the socinfo files. Keep in mind that cpuinfo is 
different from socinfo -- the cpu is just a small part of a soc.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
