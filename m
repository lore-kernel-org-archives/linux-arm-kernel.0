From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 15 Dec 2010 17:26:20 +0100
Subject: [PATCH 6/9] ARM i.MX51: Add IPU device support
In-Reply-To: <201012151649.45199.arnd@arndb.de> (Arnd Bergmann's message of
	"Wed, 15 Dec 2010 16:49:45 +0100")
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-7-git-send-email-s.hauer@pengutronix.de>
	<201012151649.45199.arnd@arndb.de>
Message-ID: <87pqt3c89f.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

Hi,

> On Thursday 09 December 2010, Sascha Hauer wrote:
>> +#define imx51_add_ipuv3(pdata) \
>> +       imx_add_ipuv3(&imx51_ipuv3_data, pdata)
>
> This looks  like a pointless abstraction, it does not make
> the code smaller or easier to read. I know it's sometimes
> tempting to use macros, but in most cases, you should try
> not to.
>

it's how things have been handled atm in the imx code. I don't have
any preference on this at all but at least either we go on with it 
or we get rid of all theses #defines. It's a matter of consistency.
The thing is that I would consider removing the imx*add* stuff to be
a cleanup and should be done in a different patch, not in a patchset
adding IPU support for imx51.

Anyway, let's wait for Sascha's point of view, he knows the imx stuff
far better than me.

Arnaud
