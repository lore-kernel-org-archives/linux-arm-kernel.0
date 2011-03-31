From: jhnikula@gmail.com (Jarkko Nikula)
Date: Thu, 31 Mar 2011 16:50:49 +0300
Subject: [PATCHv2] omap: rx51: Platform support for lp5523 led chip
In-Reply-To: <1301578692-29286-1-git-send-email-ameya.palande@nokia.com>
References: <alpine.DEB.1.10.1103311524420.2634@esdhcp041196.research.nokia.com>
	<1301578692-29286-1-git-send-email-ameya.palande@nokia.com>
Message-ID: <20110331165049.f3b83956.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Mar 2011 16:38:12 +0300
Ameya Palande <ameya.palande@nokia.com> wrote:

> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   74 ++++++++++++++++++++++++++
>  1 files changed, 74 insertions(+), 0 deletions(-)
> 
Nice keyboard and rgb led blinking:

while true; do ls /sys/class/leds/lp5523\:channel?/brightness |xargs -I
{} bash -c 'echo $((RANDOM % 255)) > {}'; done

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
