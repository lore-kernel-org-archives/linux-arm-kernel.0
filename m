From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Mar 2016 13:14:35 +0100
Subject: [PATCH 0/2] Change the the config option of mbigen driver.
In-Reply-To: <1458723993-21044-1-git-send-email-majun258@huawei.com>
References: <1458723993-21044-1-git-send-email-majun258@huawei.com>
Message-ID: <28585531.7OYJ0u0gtH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 March 2016 17:06:31 MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> In current driver, the config of mbigen driver is a configurable option and
> have nothing to do with CONFIG_ARCH_HISI.
> 
> As a module of Hisilicon SOC, the config of mbigen driver should be selected
> by CONFIG_ARCH_HISI on Hisilicon platform, but not a configurable option.
> 
> This patch set is applied to fix this problem.
> 
> 

I don't understand this one. I thought mbigen is specific to just one
of Hisilicon's SoC families, while ARCH_HISI is more generic and can
also be set for the other ones.

Maybe just add 'default ARCH_HISI' and 'depends on ARCH_HISI || COMPILE_TEST'
to the option? We should certainly keep building this driver for
compile-test on all architectures.

	Arnd
