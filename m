From: linux@baker-net.org.uk (Adam Baker)
Date: Sat, 02 Jun 2012 16:18:09 +0100
Subject: Kernel 3.4 on Dreamplug: no serial console
In-Reply-To: <loom.20120602T135715-548@post.gmane.org>
References: <loom.20120602T135715-548@post.gmane.org>
Message-ID: <3643648.ul01ikopg8@gromit>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 Jun 2012 12:20:59 Hans Kr?ner wrote:
> Hello,
> 
> I built a 3.4 kernel by grabbing the sources off kernel.org at
> /pub/linux/kernel/v3.0/linux-3.4.tar.bz2
> 
> I built both the uImage with FDT support for the Dreamplug and it's
> respective dtb, and placed them on the Dreamplug's internal SD. I made
> minor tweaks to my U-boot env to handle FDT and proceeded to boot.
> 
> At first I thought the Dreamplug was hanging while booting the kernel, since
> the console hangs at "Uncompressing Linux... done, booting the kernel."
> However, doing the "post mortem" analysis and using U-boot to look at
> __log_buf, I could see the kernel actually booting fine. I let it boot and
> then SSHd into the box, everything seems fine.

your .config doesn't seem to be attached but this sounds similiar to the 
problem I had when converting a kernel config to FDT because I didn't have

CONFIG_SERIAL_OF_PLATFORM=y

which is needed to support configuring serial ports with FDT

Hope that Helps

Adam
