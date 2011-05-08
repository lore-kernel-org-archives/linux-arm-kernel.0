From: arend@broadcom.com (Arend van Spriel)
Date: Sun, 8 May 2011 10:43:16 +0200
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTi=6BFD4OmtU1WPxjbFJQe36=mZKEA@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105061605.31625.arnd@arndb.de>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
	<1304790665.13983.10.camel@dev.znau.edu.ua>
	<BANLkTikLFff_86Fvg+jSty9vGLENiELF2Q@mail.gmail.com>
	<1304792795.13983.28.camel@dev.znau.edu.ua>
	<BANLkTi=6BFD4OmtU1WPxjbFJQe36=mZKEA@mail.gmail.com>
Message-ID: <4DC657A4.7020800@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2011 08:48 PM, Rafa? Mi?ecki wrote:
> 2011/5/7 George Kashperko<george@znau.edu.ua>:
>> I guess core id 0x800 by 0x04BF vendor and 0x800 by 0x043B vendor will
>> both be reported as ChipCommon which most likely is wrong for second
>> one. Btw, ChipCommon is 0x500 for 4706 and there will be more new core
>> codes for new Broadcom devices. Don't think its right to build core
>> names database into kernel while there will be at most few of them used
>> on particular end system.
> This is constructive, I'll fix this, thanks.

Hi Rafa?,

Late response, but I tried to tell what George clarified by the example 
above so you need nested switch.

I tend to agree with George that having this id to name conversion in 
the bus driver may be nice for debugging, but apart from memory usage it 
also gives you additional maintenance work. Leave it up to you.

Gr. AvS
