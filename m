From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 8 May 2011 12:37:15 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <20110508101609.GF27807@n2100.arm.linux.org.uk>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105061605.31625.arnd@arndb.de>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
	<1304790665.13983.10.camel@dev.znau.edu.ua>
	<BANLkTikLFff_86Fvg+jSty9vGLENiELF2Q@mail.gmail.com>
	<1304792795.13983.28.camel@dev.znau.edu.ua>
	<BANLkTi=6BFD4OmtU1WPxjbFJQe36=mZKEA@mail.gmail.com>
	<20110508101609.GF27807@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikMruTibp64GjE9qP9r80JiHgAFXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/8 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, May 07, 2011 at 08:48:10PM +0200, Rafa? Mi?ecki wrote:
>> Really, what's wrong with that? Does it kill anyone's pet we print
>> this? We also do:
>> pr_err("Scanning failed because of wrong CID\n");
>> return -1;
>> While we could drop pr_err. Why to do this? Advanced used can always
>> check what -1 means.
>
> And why return -1 when we have a system of error codes? ?I _really_ wish
> people would stop returning -1 for "some random error occurred".

You commented on imagined code, but we actually do sth similar in code.

I did this because:
1) I had no idea what err code would be valid for invalid EPROM layout
(content). Nothing from include/asm-generic/errno-base.h sounds
reasonable.
2) I wanted to use different error codes for different EPROM layout
issues. Sometimes we don't get CIA block. Sometimes we don't get CIB
block. Sometimes there is problem with master port (not found in EPROM
when expected). They all would probably use the same errno.

Could you help me with this?

-- 
Rafa?
