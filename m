From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 5 Sep 2012 15:27:50 +0200
Subject: [PATCH 5/8] gpio: 74x164: Add output pin support
In-Reply-To: <50474D51.40007@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-5-git-send-email-maxime.ripard@free-electrons.com>
 <20120905112012.13ce2c86@skate> <20120905114645.57bfe591@eb-e6520>
 <20120905120906.12d08bf5@skate> <20120905122652.7c752e96@eb-e6520>
 <20120905135646.3bbf98fa@skate> <20120905142244.003e5e4b@eb-e6520>
 <20120905142952.2e1f12fd@skate> <20120905145411.195f8438@eb-e6520>
 <50474D51.40007@free-electrons.com>
Message-ID: <20120905152750.056a47cc@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 05 Sep 2012 15:02:09 +0200,
Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :
> And what about using the spi_message structure and one single spi_sync
> instead of several spi_write ? Would that work in our case ?
> 
if you are sure that the controler will keep the chip select low during
the whole transfer that should work (that means on some spi controllers
you will have to configure the chip select as a plain gpio depending on
the number of buffer you chain).

Eric
