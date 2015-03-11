From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Mar 2015 17:46:19 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55007ADD.6080505@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com>
 <55007ADD.6080505@list.ru>
Message-ID: <20150311174618.GE8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 08:26:53PM +0300, Stas Sergeev wrote:
> Hello Thomas, thanks for that info!
> 
> Is there a quick way to test that?
> I used memmap=0x20000000$0xe0000000 but nothing changed...

Use mem=0xe0000000 instead.  memmap= isn't supported on ARM.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
