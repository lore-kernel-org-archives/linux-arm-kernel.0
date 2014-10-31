From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Oct 2014 09:35:57 +0000
Subject: [PATCH v3 2/6] uio: Add new UIO_MEM_PHYS_CACHE type for mem
 regions
In-Reply-To: <6D33D50E-2DD1-482C-B05E-45B237F3B779@codeaurora.org>
References: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
 <1413871011-4101-3-git-send-email-ankit.jindal@linaro.org>
 <6D33D50E-2DD1-482C-B05E-45B237F3B779@codeaurora.org>
Message-ID: <20141031093557.GT27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 08:38:23AM +0200, Kumar Gala wrote:
> Rather than adding a new type, why not allow the driver to set the

Please wrap your message.

That doesn't work.  A pgprot_t contains more than just memory type
information.  It also contains access permissions.  In other words,
if the user requested read-only or a read-write mapping, the
permissions will be different.

If you always use your stored pgprot_t, then you will override the
users requested permissions.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
