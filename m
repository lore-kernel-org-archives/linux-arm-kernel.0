From: Giuseppe.Calderaro@arm.com (Giuseppe Calderaro)
Date: Wed, 14 Jul 2010 16:15:08 +0100
Subject: [PATCH v3 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <20100714150117.16555.75662.stgit@e102109-lin.cambridge.arm.com>
References: <20100714145802.16555.48563.stgit@e102109-lin.cambridge.arm.com>
	<20100714150117.16555.75662.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <000001cb2367$590b2f60$0b218e20$@Calderaro@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+#define writeb_relaxed(v,c)	((void)__raw_writeb(v,__mem_pci(c)))
+#define writew_relaxed(v,c)	((void)__raw_writew((__force u16) \
+					cpu_to_le16(v),__mem_pci(c)))
+#define writel_relaxed(v,c)	((void)__raw_writel((__force u32) \

Adding the cast here means that someone could use the __raw_writeb/w/l
macros and still get the side effect.
What about adding the same cast to the __raw_* defines as well?

Giuseppe
