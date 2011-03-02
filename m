From: maxime.coquelin-nonst@stericsson.com (Maxime Coquelin)
Date: Wed, 2 Mar 2011 09:50:39 +0100
Subject: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
In-Reply-To: <4D6DBF59.2050005@bluewatersys.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>	<20110216115729.GA29817@besouro.research.nokia.com>	<4D6B78BF.1020102@stericsson.com>	<4D6C7B56.9060109@codeaurora.org>	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>	<4D6D9B10.9000606@codeaurora.org>	<4D6D9D06.2020204@bluewatersys.com>	<4D6D9FC7.1090206@codeaurora.org>	<4D6DA290.2010607@bluewatersys.com>	<4D6DAA24.3000204@codeaurora.org>	<4D6DAE6E.4030701@bluewatersys.com>	<4D6DB1B1.4060908@codeaurora.org>	<4D6DB566.4090908@bluewatersys.com>	<4D6DB7CB.7070701@codeaurora.org>
	<4D6DBAED.7070805@bluewatersys.com> <4D6DBD8C.70904@codeaurora.org>
	<4D6DBF59.2050005@bluewatersys.com>
Message-ID: <4D6E04DF.3070905@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2011 04:54 AM, Ryan Mallon wrote:
> On 03/02/2011 04:46 PM, Saravana Kannan wrote:
>> On 03/01/2011 07:35 PM, Ryan Mallon wrote:
>>> The only real objection I have to adding the SoC family information is
>>> basically to discourage it being abused by userspace. I can see it being
>>> useful in debug situations, but I can also see stupid userspace
>>> applications explicitly testing for some particular SoC, rather than
>>> more correctly (IMHO) checking for presence of certain drivers etc.
>> True, but so many other things could be misused by stupid userspace
>> programs. When there are legitimate usecases, I think we shouldn't
>> prevent them just because we think a stupid userspace program could
>> misuse it.
>>
>> Again, although you might not be gung-ho about this, I think I have at
>> least made you indifferent/mildly supportive to adding socinfo. If you
>> don't mind, I would like to wait for others to chime in before
>> continuing this discussion.
> Agreed.
>
> In general I am in support of having the SoC information exposed
> somewhere. I think we just want to be careful that it doesn't become a
> dumping ground for anything and everything SoC related whether the
> information is useful or not. I think each piece of exposed information
> should have a genuine use case, not just "because we can".
I definitely agree we should not export every SoC-related information 
just because we can do it.
The first goal of this interface was to export some SoCs IDs, as we need 
this kind of information for some user-space tools.
Does someone need to export other information than the mach name and 
some IDs?

As proposed in my previous mail, do you agree to have a unified file for 
all vendors, which exports the unique silicon ID of the chip?

Regards,
Maxime
