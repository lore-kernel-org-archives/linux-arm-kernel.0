From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 04 Nov 2010 21:30:26 +0100
Subject: [PATCH 2/2] ARM: imx: Add mx53 support to common msl functions.
In-Reply-To: <86A0E76937111F4C92FABEC0A20988510523CEC2@az33exm21>
References: <1288736227-800-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1288736227-800-2-git-send-email-Dinh.Nguyen@freescale.com>
	<4CD12833.8060204@eukrea.com>
	<86A0E76937111F4C92FABEC0A20988510523CEC2@az33exm21>
Message-ID: <4CD317E2.9090504@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

Le 04/11/2010 20:21, Nguyen Dinh-R00091 a ?crit :
> Reading the ROM code is probably the most reliable way to get the correct
> silicon revision. Because the ROM that is on the chip is "most likely"
> up-to-date with the silicon. "Most likely" means that 95% of the time, when
> you get a new silicon, the ROM code will get updated. There is still a
> chance that a new silicon will not require a ROM update.
>
> Also the other reason is that sometimes the fuses that identify the silicon
> revision that are used by the IIM are sometimes not blown to reflect the
> correct revision in pre-production parts. MX51 is a post production part,
> so in theory, the fuses are blown correctly. But since we made MX51 boards
> available prior to going into production, reading from the IIM is not as
> reliable as reading the ROM.
>
Don't you think we should use the documented register which (if we believe the 
documentation) should be 100% reliable for production CPU instead of this 
undocumented method which from what you say is 95% reliable and here to handle 
the case of pre production CPU ?

The same problem occured on i.MX35 silicon 2.1 which where not correctly 
detected using the ROM code.

Eric
