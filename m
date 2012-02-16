From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 08:55:37 +0000
Subject: Question: how to make one page readonly on ARM
In-Reply-To: <CAADzPW2bW8Rx+V726L+Mfji+-+rFxwwYO0nkKtgMTM0XtQ7BpQ@mail.gmail.com>
References: <CAADzPW2bW8Rx+V726L+Mfji+-+rFxwwYO0nkKtgMTM0XtQ7BpQ@mail.gmail.com>
Message-ID: <20120216085537.GJ13673@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 12:54:27PM +0800, ??? wrote:
> Hi,
> I get one page by __get_free_page and can make it readonly by
> set_memory_ro on X86,
> but how to do this on ARM?

You can't, because we map all kernel space with 1MB section mappings.
