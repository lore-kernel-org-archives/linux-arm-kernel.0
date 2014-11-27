From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 10:05:57 +0100
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <5E6565C8-E868-4559-978A-681045F3582F@redhat.com>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
 <5E6565C8-E868-4559-978A-681045F3582F@redhat.com>
Message-ID: <9101942.u99uxeQ3XX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 02:39:59 Jon Masters wrote:
> We're looking at this at the moment (in addition to having the ACPI specification
> clarified to indicate that there is no safe default assumption, requiring that
> DMA masters always indicate their coherency or otherwise via a _CCA whether true
> or false). 

I think for arm64, this should be easy: since ACPI is only for servers, we can
rely on the fact that the devices have cache-coherent DMA all the time. Let's
not over-complicate the ACPI case with all the special hacks we need for embedded.

	Arnd
