From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Oct 2009 09:09:38 +0100
Subject: [PATCH] Use CONFIG_VECTORS_BASE instead of hardcoded 0xffff0000.
In-Reply-To: <20091021090438.0ec458dd.benoit.fouet@free.fr>
References: <1256054856-20404-1-git-send-email-benoit.fouet@free.fr>
	<63386a3d0910201251n4e6fec18le5a2d2cd0941be78@mail.gmail.com>
	<20091020201009.GA14305@n2100.arm.linux.org.uk>
	<20091021090438.0ec458dd.benoit.fouet@free.fr>
Message-ID: <20091021080938.GA28831@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2009 at 09:04:38AM +0200, Benoit Fouet wrote:
> Reading the DDI0344D (Cortex A8 r2p1 trm), it seemed to me that this
> was configurable with the security extension:
> http://infocentre.arm.com/help/topic/com.arm.doc.ddi0344d/Babfbcae.html
> 
> although my patch was very likely the wrong approach (changing
> VECTORS_BASE does not really make sense, as this is the one that can
> not be remapped), there are still processors in the wild in which you
> can configure the base address of the exception vectors.

However, the page at 0xffff0000 on MMU processors is part of the
kernel<->user API and its address can not be changed.

As I say, the patch does not make any sense.
