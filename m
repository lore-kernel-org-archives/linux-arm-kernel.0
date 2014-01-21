From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jan 2014 11:01:07 +0000
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140121075922.2a83e076@ipc1.ka-ro>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
 <20140120122840.36520f37@ipc1.ka-ro> <20140120123627.1147f252@ipc1.ka-ro>
 <20140120123849.GC15937@n2100.arm.linux.org.uk>
 <20140120150902.207b9d66@ipc1.ka-ro>
 <20140120151152.GE15937@n2100.arm.linux.org.uk>
 <20140121075922.2a83e076@ipc1.ka-ro>
Message-ID: <20140121110107.GS15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 07:59:22AM +0100, Lothar Wa?mann wrote:
> The file is automatically removed after the timeout has expired (or
> the frimware has been loaded).
> Thus you must check for it within the timeout period during boot.

... which is impossible if imx-sdma is built into the kernel - it
expires while the initramfs has only just started running, giving a
very narrow window for userspace to load firmware.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
