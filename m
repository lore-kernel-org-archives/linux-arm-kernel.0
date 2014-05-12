From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 May 2014 09:51:41 +0200
Subject: [RFC][PATCH 2/2] ARM: ioremap: Add IO mapping space reused
 support.
In-Reply-To: <1399861195-21087-3-git-send-email-superlibj8301@gmail.com>
References: <1399861195-21087-1-git-send-email-superlibj8301@gmail.com>
 <1399861195-21087-3-git-send-email-superlibj8301@gmail.com>
Message-ID: <5146762.jba3IJe7xt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 May 2014 10:19:55 Richard Lee wrote:
> For the IO mapping, for the same physical address space maybe
> mapped more than one time, for example, in some SoCs:
> 0x20000000 ~ 0x20001000: are global control IO physical map,
> and this range space will be used by many drivers.
> And then if each driver will do the same ioremap operation, we
> will waste to much malloc virtual spaces.
> 
> This patch add IO mapping space reused support.
> 
> Signed-off-by: Richard Lee <superlibj@gmail.com>

What happens if the first driver then unmaps the area?

	Arnd
