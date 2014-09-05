From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Sep 2014 20:20:44 +0200
Subject: [PATCH] PCI: mvebu: Fix uninitialized variable in
 mvebu_get_tgt_attr()
In-Reply-To: <20140905174122.GD8080@google.com>
References: <1407512045-26969-1-git-send-email-geert+renesas@glider.be>
 <20140905174122.GD8080@google.com>
Message-ID: <20140905202044.4c166a43@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Fri, 5 Sep 2014 11:41:22 -0600, Bjorn Helgaas wrote:

> This fix looks right to me.  I added a stable tag as follows.  Thomas
> and/or Jason, and you ack this?

Hum, I think I would actually prefer something like:

                if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
                        rtype = IORESOURCE_IO;
                else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
                        rtype = IORESOURCE_MEM;
+		else
+			continue;

So that we're explicit with the fact that we only care about I/O and
MEM32 resource types.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
