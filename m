From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Nov 2012 15:09:54 +0000
Subject: [PATCH v2] ARM: implement optimized percpu variable access
In-Reply-To: <20121129150509.GB19866@mudshark.cambridge.arm.com>
References: <1354200764-23751-1-git-send-email-robherring2@gmail.com>
 <20121129150509.GB19866@mudshark.cambridge.arm.com>
Message-ID: <20121129150954.GK19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 03:05:09PM +0000, Will Deacon wrote:
> It's really not safe moving the cpu_init that early because we're running
> strongly ordered at that point, so locks aren't working.

Maybe just move it before the printk?
