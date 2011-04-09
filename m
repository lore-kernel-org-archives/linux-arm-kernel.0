From: arend@broadcom.com (Arend van Spriel)
Date: Sat, 9 Apr 2011 13:01:39 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <1302333026.18361.8.camel@dev.znau.edu.ua>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop>
	<BANLkTin1yyow595tcYveB5fh8q3x+U_GOw@mail.gmail.com>
	<op.vtmqm7fw3ri7v4@arend-laptop>
	<1302333026.18361.8.camel@dev.znau.edu.ua>
Message-ID: <op.vtn3k12g3ri7v4@arend-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 09 Apr 2011 09:10:26 +0200, George Kashperko <george@znau.edu.ua>  
wrote:

>
>> On Fri, 08 Apr 2011 18:56:13 +0200, Rafa? Mi?ecki <zajec5@gmail.com>  
>> wrote:
>>
>> > 2011/4/6 Arend van Spriel <arend@broadcom.com>:
>> >> 3. Device identification
>> >>
>> >> The cores are identified by manufacturer, core id and revision in  
>> your
>> >> patch. I would not use the revision because 4 out of 5 times a  
>> revision
>> >> change does indicate a hardware change but no change in programming
>> >> interface. The enumeration data does contain a more selective field
>> >> indicating the core class (4 bits following the core identifier). I
>> >> suggest
>> >> to replace the revision field by this class field.
>> >
>> > Could you say something more about *class*, please? For my BCM43224 it
>> > seems to be 0x0. WIll check BCM4313 in a moment.
>> >
>>
>> In principal the manufacturer id is unique (defined/assigned by JEDEC
>> www.jedec.org) and the chip id and chip class are defined by the
>> manufacturer. So I can only indicate what classes Broadcom uses in
>> combination with the manufacturer id BRCM, ARM and MIPS.
>>
>> /* Component Classes */
>> #define	CC_SIM			0
>> #define	CC_EROM			1
>> #define	CC_CORESIGHT		9
>> #define	CC_VERIF		0xb
>> #define	CC_OPTIMO		0xd
>> #define	CC_GEN			0xe
>> #define	CC_PRIMECELL		0xf
>>
>> Looking at this it seems strange that you see a class value of 0x0. It  
>> may
>> be rarely used or for non-production chips only (for simulation, chip
>> bringup) which may require additional (debug) functions. So question is
>> whether you will need it, but it is specified by ARM and it is up to
>> manufacturers to use it. So I it is better to be safe than sorry and  
>> have
>> this in the device id.
>>
>> Gr. AvS
> When parsing bcm4716 EROM I have
> cia & CIA_CCL_MASK equal to 0 for all 9 cores
>
> You mentioned ARM DMP (Device Management Plugin) several times in
> earlier messages some time ago but I can't find anything relevant about
> that at ARM infocenter. Any chance you can point more precise location
> for any DMP reference?

I believe this is part of the CoreLink AMBA Designer tool, which is used  
to design/configure a SoC. The DMP is ARM system IP and so references are  
under ARM copyright. You need a special account with ARM to get access to  
these references.

Gr. AvS
-- 
"The world is indeed comic, but the joke is on mankind." ? H.P. Lovecraft
