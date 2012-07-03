From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 Jul 2012 14:24:47 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <4FF2EEA1.6080204@linaro.org>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
 <20120703123552.GC25995@sirena.org.uk>
 <4FF2EEA1.6080204@linaro.org>
Message-ID: <20120703132447.GN29030@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 02:07:45PM +0100, Lee Jones wrote:
> On 03/07/12 13:35, Mark Brown wrote:

> >Do we really want to create MFD cells like this (which are really Linux
> >internal things and might vary if another OS or another version of Linux
> >changes its internal abstractions) from the device tree?

> We're not creating them. We're merely using current infrastructure.

*Very* recently added infrastructure which caused you to notice this...

> Before, when we probed each device from Device Tree we came up
> against some fairly major limitations of the Device Tree. As a
> result, Arnd and I agreed that this was the way to go.

I'm really unconvinced that instnatiating the MFD cells from device tree
is in general a good idea.

> See c5395e7ed8f16cc7bb72a783de68659db5aed515 for a short description
> of the troubles we faced.

$ git show c5395e7ed8f16cc7bb72a783de68659db5aed515
fatal: bad object c5395e7ed8f16cc7bb72a783de68659db5aed515
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120703/8cfced81/attachment.sig>
