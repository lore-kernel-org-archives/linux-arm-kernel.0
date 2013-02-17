From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 17 Feb 2013 10:19:58 +0000
Subject: [PATCH 2/2] of: use platform_device_add
In-Reply-To: <20130217074317.GB16632@S2101-09.ap.freescale.net>
References: <1358473200-17886-1-git-send-email-grant.likely@secretlab.ca>
 <1358473200-17886-2-git-send-email-grant.likely@secretlab.ca>
 <20130217030331.GA15048@S2101-09.ap.freescale.net>
 <20130217074317.GB16632@S2101-09.ap.freescale.net>
Message-ID: <20130217101958.GR17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 03:43:20PM +0800, Shawn Guo wrote:
> It also breaks all of_amba_device users.
> 
> of_amba_device_create() --> amba_device_add() --> request_resource()
> and fails.

Presumably that's because we no longer know what the parent resource
is supposed to be?
