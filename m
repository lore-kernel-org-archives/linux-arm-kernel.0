From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 17:01:51 +0000
Subject: [PATCH v2 2/28] drm/i2c: tda998x: check more I/O errors
In-Reply-To: <20140109115745.5f81523e@armhf>
References: <20140109115745.5f81523e@armhf>
Message-ID: <20140111170151.GO15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:57:45AM +0100, Jean-Francois Moine wrote:
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

This lacks a description detailing why this change is necessary.  While
I can see the sense in preventing a subsequent write succeeding after a
failed page register write, we still continue blindly on accessing the
device after a read or write fails.  For istance, how many calls to
reg_write() or reg_read() are checked for failure?

That said, the patch does not appear to create any detrimental effects,
so it gets a tested-by but *no* acked-by.  Please give it a better
description justifying this change for an acked-by.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
