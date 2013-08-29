From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Aug 2013 19:20:13 +0200
Subject: [PATCH RFC v2 16/16] ARM: zynq: Don't call of_clk_init()
In-Reply-To: <89b68978-7eeb-43e1-a456-d864ed313da5@DB8EHSMHS026.ehs.local>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308291537.54608.arnd@arndb.de>
 <89b68978-7eeb-43e1-a456-d864ed313da5@DB8EHSMHS026.ehs.local>
Message-ID: <201308291920.13983.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 August 2013, Michal Simek wrote:
> Is there any plan to remove all of them?
> I expect that on almost all platforms it is a need to have at least one
> early hook to be able to setup things.

In an ideal world, we wouldn't need any, and on arm64 we don't plan to
introduce callbacks in the first place. We don't put a lot of effort
into eliminating all the ones from existing platforms in the near future,
but but I do hope to have a situation where we don't use any callbacks
for newly introduced 32-bit platforms soon, and remove a lot of the
existing callbacks over time when we have the chance (like now for the
clk init).

	Arnd
