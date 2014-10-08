From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Oct 2014 12:41:12 +0100
Subject: [PATCH 1/6] ARM: cygnus: Initial support for Broadcom Cygnus SoC
In-Reply-To: <54351D49.7040104@broadcom.com>
References: <sbranden@broadcom.com>
 <1412746025-11998-1-git-send-email-sbranden@broadcom.com>
 <1412746025-11998-2-git-send-email-sbranden@broadcom.com>
 <20141008081112.GB5182@n2100.arm.linux.org.uk>
 <54351D49.7040104@broadcom.com>
Message-ID: <20141008114112.GG5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 04:17:29AM -0700, Scott Branden wrote:
> Thanks - was unaware of this functionality.  Will add .l2c_aux_val and  
> .l2c_aux mask to DT_MATCHINE_START.  BUT, what happens when we need to  
> add trustzone support and make SMC call to secure monitor?

You will then need to implement the .l2c_write_sec initialiser in the
same place.

Note that there's work to revise the trustzone support in this area
which will probably be merged for 3.19.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
