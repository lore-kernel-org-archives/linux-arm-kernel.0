From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 May 2013 19:23:05 +0100
Subject: [PATCH -v8 11/11] Move arch/x86 reboot= handling to generic
 kernel.
In-Reply-To: <1367937595-32241-12-git-send-email-holt@sgi.com>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
 <1367937595-32241-12-git-send-email-holt@sgi.com>
Message-ID: <20130508182304.GP18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 09:39:55AM -0500, Robin Holt wrote:
> +		case 's':
> +			reboot_mode = REBOOT_WARM;
> +		case 'h':
> +			reboot_mode = REBOOT_COLD;
> +		case 'g':
> +			reboot_mode = REBOOT_GPIO;

Further to Ingo's comments, also note that the above is broken.  Any
of s,h,g will result in REBOOT_GPIO being set which is clearly wrong.
