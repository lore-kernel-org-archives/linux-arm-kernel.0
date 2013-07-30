From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Jul 2013 11:23:33 +0100
Subject: [PATCH] arm: update advice on kernel and FDT load address.
In-Reply-To: <20130730094118.GF11527@mudshark.cambridge.arm.com>
References: <1375102578-5869-1-git-send-email-ian.campbell@citrix.com>
 <20130729135000.GK32383@mudshark.cambridge.arm.com>
 <1375106635.12741.8.camel@kazak.uk.xensource.com>
 <alpine.LFD.2.03.1307292234040.15022@syhkavp.arg>
 <20130730094118.GF11527@mudshark.cambridge.arm.com>
Message-ID: <20130730102333.GO24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 10:41:18AM +0100, Will Deacon wrote:
> Hmm, how does that work with CONFIG_INITRAMFS_SOURCE, where the initramfs
> is built into the zImage? Would this impose a 32MB uncompressed limit on the
> size of the kernel + initramfs?

It does, especially if you have things like the CPU resume path in the
.data section so it can access the data necessary to resume without
violating the read-only nature of .text.
