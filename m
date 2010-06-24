From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Thu, 24 Jun 2010 16:37:14 +0200
Subject: [PATCH v2] otg/ulpi.c : fix register write
In-Reply-To: <4C236600.2030605@compulab.co.il>
References: <1277311435-12027-1-git-send-email-eric@eukrea.com>
	<4C236600.2030605@compulab.co.il>
Message-ID: <4C236D9A.4030707@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 24/06/2010 16:04, Igor Grinberg a ?crit :
> ulpi_set_flags is used to set the OTG flags and not to clear them,
> also it is a static function and is not a part of struct otg_transceiver,
> so it cannot be called from outside the ulpi.c, thus after the ulpi_create,
> it is never called.
> I think, currently, this should stay as it is.
>
OK, the problem that when one flag is set, you can't clear it without 
resetting the PHY.

Eric
