From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Mar 2013 11:23:57 -0700
Subject: [PATCH 05/32] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <22387327.428751362559215433.JavaMail.weblogic@epml07>
References: <22387327.428751362559215433.JavaMail.weblogic@epml07>
Message-ID: <20130306182357.GB2433@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 08:40:26AM +0000, Jingoo Han wrote:

> Yes, I am developing a PCIe driver for Samsung Exynos SoCs.
> Also, 2 days ago, I submitted the PCIe driver.
> 
> http://www.spinics.net/lists/linux-pci/msg20548.html
> http://www.spinics.net/lists/linux-pci/msg20549.html
> 
> If someone look at my code, it will be very helpful.

I took a quick peek at your DT bindings and I think they are way off
base. You need to read the thread(s) related to the new Armada and
Tegra drivers. Your bindings should look closer to them. 

You need to have DT bindings that follow the OF PCI requirements.

You need to determine if your hardware follows the PCI-SIG
requirements and includes a root port bridge config space, this will
guide if you need to use seperate PCI domains and DT stanzas, or if a
single domain and stanza should be used.

Please include lspci output in future commit messages

If you CC me the next time you post these patches I may be able to try
and help a bit, but lets start a new thread for that sort of
discussion. :)

Regards,
Jason
