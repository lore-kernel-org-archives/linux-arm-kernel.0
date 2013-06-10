From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jun 2013 00:22:49 +0100
Subject: [PATCH] mfd: vexpress: Make the driver optional for arm and arm64
In-Reply-To: <1370876955-26050-1-git-send-email-pawel.moll@arm.com>
References: <1370876955-26050-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130610232249.GH18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 04:09:15PM +0100, Pawel Moll wrote:
> The driver can be used on either arm or arm64 platforms, but
> the latter doesn't have any platform-specific configuration
> options, so it must be possible to manually enable the driver.
> 
> As the gpiolib is optional for arm64 arch, the gpio/led code
> must be compiled conditionally.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  drivers/mfd/Kconfig           |  3 ++-
>  drivers/mfd/vexpress-sysreg.c | 10 ++++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> Hi Samuel,
> 
> Could you please queue this small change for 3.11?

Please use #ifdef rather than a single #if defined().  #if defined()
on its own is unnecessarily ugly.
