From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 18:18:00 +0000
Subject: [PATCH 2/2] ARM: pcmcia: fix checkpatch.pl issues in soc_common.c
In-Reply-To: <4BAB38B1.8080404@ru.mvista.com>
References: <1269471898-26301-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<1269471898-26301-2-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<20100324230729.GA21359@n2100.arm.linux.org.uk>
	<4BAB38B1.8080404@ru.mvista.com>
Message-ID: <20100326181800.GB21682@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 01:19:29PM +0300, Sergei Shtylyov wrote:
> Hello.
>
> Russell King - ARM Linux wrote:
>
>>> -	debug(skt, 2, "mask: %s%s%s%s%s%sflags: %s%s%s%s%s%sVcc %d Vpp %d irq %d\n",
>>> -			(state->csc_mask==0)?"<NONE> ":"",
>>> -			(state->csc_mask&SS_DETECT)?"DETECT ":"",
>>> -			(state->csc_mask&SS_READY)?"READY ":"",
>>> -			(state->csc_mask&SS_BATDEAD)?"BATDEAD ":"",
>>> -			(state->csc_mask&SS_BATWARN)?"BATWARN ":"",
>>> -			(state->csc_mask&SS_STSCHG)?"STSCHG ":"",
>>> -			(state->flags==0)?"<NONE> ":"",
>>> -			(state->flags&SS_PWR_AUTO)?"PWR_AUTO ":"",
>>> -			(state->flags&SS_IOCARD)?"IOCARD ":"",
>>> -			(state->flags&SS_RESET)?"RESET ":"",
>>> -			(state->flags&SS_SPKR_ENA)?"SPKR_ENA ":"",
>>> -			(state->flags&SS_OUTPUT_ENA)?"OUTPUT_ENA ":"",
>>> +	debug(skt, 2,	"mask: %s%s%s%s%s%s "
>>> +			"flags: %s%s%s%s%s%s Vcc %d Vpp %d irq %d\n",
>>>     
>>
>> NAK.  Breaking kernel messages across multiple lines makes them impossible
>> to grep for.  checkpatch.pl is wrong on this one.
>>   
>
>   I'd disagree in this case. Anybody will hardly grep for "mask:  
> %s%s%s%s%s%sflags: %s%s%s%s%s%s".

Well, I disagree on a matter of principle with you.  If you want to avoid
the line going over 80 columns, move the entire string onto the next line.
Then we can have the entire string intact _and_ we can have it fitting
within 80 columns.
