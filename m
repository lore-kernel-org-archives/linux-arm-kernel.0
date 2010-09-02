From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 2 Sep 2010 23:18:18 +0900
Subject: mmc over SPI on DM6467 based board. card not detected.
In-Reply-To: <BLU124-W40A2B008B886302781867B4870@phx.gbl>
References: <4C516634.5040804@criticallink.com>
	<877hjd106u.fsf@deeprootsystems.com>
	<4C7702EB.8040905@criticallink.com>
	<8762ywrvpt.fsf@deeprootsystems.com>
	<4C77E6BD.4000303@criticallink.com>
	<87fwy0orsg.fsf@deeprootsystems.com>
	<BLU124-W40A2B008B886302781867B4870@phx.gbl>
Message-ID: <AANLkTikywOgVwse640vAVAuE7wXpvgEXaJkoiinv9sdG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 28, 2010 at 10:26 PM, Sumesh Kaana <sumeshkkn@hotmail.com> wrote:
> Hi all,
>
>
>
> I am trying to mount SD-Card over SPI on our custom DM6467 board. davinci
> spi controller driver and mmc over spi drver are selected in the menuconfig.
> i am using davinci-PSP.03-XX-00-37 kernel.
>
> I have also edited board initialization file to probe the MMC card under SPI
> as below:

First, make sure
a) you provide 3.3v and ground properly.
b) the slot, card and connections are OK by using spi_gpio driver to
run the same pins,
   if the SPI controller pins could be muxed into GPIO mode(usually
they could be).

Probably the source clock doesn't allow for scaling down to within
400KHz, give it a closer look.
