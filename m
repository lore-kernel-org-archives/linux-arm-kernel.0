From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sun, 5 Jun 2011 09:51:28 +0200
Subject: [PATCH v4] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <BANLkTikMGkwVp4bGPbdSdx61PLUw23sWkFFxyThLTMkrnqpCCw@mail.gmail.com>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC4A7E@AUSP01VMBX24.collaborationhost.net>
	<1307125685-5110-1-git-send-email-ynezz@true.cz>
	<BANLkTikMGkwVp4bGPbdSdx61PLUw23sWkFFxyThLTMkrnqpCCw@mail.gmail.com>
Message-ID: <20110605075128.GS16318@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> [2011-06-03 11:43:27]:

Hi,

> It would be nicer to introduce a function pointer here, that's filled
> in by the ts72xx.c machine_init function but NULL by default:

yes, I didn't liked the modification of the shared machine code either and I
personally dislike the ifdefs also, but

> Otherwise, other boards would add another if statement, any new ts72xx
> board would need to modify the soc-common header, etc.

this is very unlikely to happen. The TS's ep93xx based products seems to be
EOL, they'll just sell them until they've parts/SOC available.

I'll leave the decision up to the maintainers.

-- ynezz
