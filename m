From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Apr 2015 20:14:21 +0100
Subject: how to mapping device memory in head.S
In-Reply-To: <CADUS3onGVjDd3Mquda2bgeLFvmxZUUYdiwzJ4nd7XjhyyudiDw@mail.gmail.com>
References: <CADUS3onGVjDd3Mquda2bgeLFvmxZUUYdiwzJ4nd7XjhyyudiDw@mail.gmail.com>
Message-ID: <20150412191420.GP12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 12, 2015 at 08:23:59PM +0800, yoma sophian wrote:
> hi all:
> I need to map peripheral address in head.S for early usage.

Basically, you do not.

Please explain in detail what you're trying to do.

> 1. CONFIG_DEBUG_LL is  using short-descriptor 1st-level section
> descriptor formats. Is it possible to use short-descriptor 2nd-level
> small page descriptor in head.S?

Definitely not, there is no memory management at that stage to allocate
a 2nd level descriptor table.

> 2. The peripheral mapping virtual address created in head.S is need to
> access even after paging_init. Is it possible to put the mapping in
> the persistent mapping in head.S?

No, we don't support that.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
