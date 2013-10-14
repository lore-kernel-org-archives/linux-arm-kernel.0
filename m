From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 14 Oct 2013 09:44:44 +0100
Subject: [PATCH 3/3] virtio: mmio: access configuration space as
 little-endian
In-Reply-To: <1381502171-8187-4-git-send-email-marc.zyngier@arm.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <1381502171-8187-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381740284.3247.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-10-11 at 15:36 +0100, Marc Zyngier wrote:
> virtio_mmio defines the config space to be little-endian. 

This is not exactly true. The configuration *registers* (magic value,
queue selector etc.) are always LE, yes. The configuration *space* (the
free-form stuff starting at 0x100) is still guest-endian.

The spec-in-works makes everything LE and the driver will most likely
get accessors for the config space. Rusty had a go at this a while ago:

http://thread.gmane.org/gmane.linux.kernel.virtualization/19397

Pawe?
