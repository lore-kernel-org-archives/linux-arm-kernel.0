From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2011 16:19:34 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
In-Reply-To: <BANLkTim6iCAsViJQS4XrY-XObs8pp-BiQQ@mail.gmail.com>
References: <BANLkTim7Uj2tsgFngWhUqFK_hk3Leg+sQA@mail.gmail.com>
	<201104171938.12834.arnd@arndb.de>
	<BANLkTim6iCAsViJQS4XrY-XObs8pp-BiQQ@mail.gmail.com>
Message-ID: <201104181619.35115.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2011, Rafa? Mi?ecki wrote:
> W dniu 17 kwietnia 2011 19:38 u?ytkownik Arnd Bergmann <arnd@arndb.de> napisa?:
>
> > In general, the bus_type directly relates to how a device gets probed.
> > If broadcom uses the same basic register layout as regular AMBA devices,
> > it should use the amba bus type.
> 
> From Broadcom side we *could* use some registers that are AMBA
> specific, they are present... but there is totally no point in doing
> that. Everything we use is Broadcom specific.
> 
> 
> > I think it would be fine to extend the AMBA bus slightly if there are
> > just minor differences.
> 
> As I said, Broadcom specific driver use nothing from AMBA common
> things. Plus we implement routines that are Broadcom specific and no
> other platform will use them.

You mean the hardware has two sets of registers containing the same
information, one of them the standard registers, and one with broadcom
specific ones?

Why don't you just use the standard ones then?

	Arnd
