From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 13:29:47 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <4FF58571.2090807@linaro.org>
References: <20120703123552.GC25995@sirena.org.uk>
 <4FF2EEA1.6080204@linaro.org>
 <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <4FF2F82D.9080507@linaro.org>
 <20120703142123.GQ29030@opensource.wolfsonmicro.com>
 <4FF54406.3000307@linaro.org>
 <20120705094541.GK4111@opensource.wolfsonmicro.com>
 <4FF57EA9.7060107@linaro.org>
 <20120705120600.GT4111@opensource.wolfsonmicro.com>
 <4FF58571.2090807@linaro.org>
Message-ID: <20120705122947.GY4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 01:15:45PM +0100, Lee Jones wrote:
> On 05/07/12 13:06, Mark Brown wrote:

> >You seemed to be suggesting that your fix was in some way related to the
> >DT changes in the MFD core.  I'm unsure as to the relationship here.

> How is it not related? In English the patch would say; "Only
> register the AB8500 via the MFD API when we're booting with Device
> Tree. This allows AB8500 related devices to be registered in the
> normal way, rather than registering them individually using DT and
> prevents duplicate registration when we are not executing a Device
> Tree enabled boot."

This is what you said before and it still doesn't make much sense to me.
I'd expect that if anything your first statement would be the opposite
of what happens - it seems like your non-DT code is doing something
really odd.  If anything I'd expect adding a DT to add duplicate
registrations, I'd not expect it to remove registrations.  

What I'd expect is that if we can figure out that we need to register
the AB8500 automatically without any information from DT then we should
be able to figure out exactly the same thing in the non-DT case.  I
would therefore expect that the change would instead be something which
removes the other source of registrations.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/a775c07d/attachment.sig>
