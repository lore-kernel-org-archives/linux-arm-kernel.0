From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 17:24:14 +0000
Subject: [PATCH] arm: prima2: export sirfsoc_reset_device as the common
 API of drivers
In-Reply-To: <1364353599-30731-1-git-send-email-Barry.Song@csr.com>
References: <1364353599-30731-1-git-send-email-Barry.Song@csr.com>
Message-ID: <201303281724.14385.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Barry Song wrote:
> From: "renwei.wu" <renwei.wu@csr.com>
> 
> sirfsoc_reset_device() should be an API used by other SiRF drivers.
> This patch exports it.
> devices who want to reset just need to add reset_bit in .dts.
> 
> Signed-off-by: Renwei Wu <Renwei.Wu@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

The interface is currently not used in the mainline kernel, and
having a global header for it is not a good solution in the long
run. Please have a look at the patches labeled "Reset controller
API to reset IP modules on i.MX5 and i.MX6" from Philipp Zabel
and coordinate with him or base your own drivers on his code
when you get it upstream.

	Arnd
