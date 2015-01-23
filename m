From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 13:54:23 -0800
Subject: [GIT PULL RESEND] pxa for v3.20
In-Reply-To: <87egqpff9m.fsf@free.fr>
References: <87egqpff9m.fsf@free.fr>
Message-ID: <20150123215423.GD20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 08:01:09PM +0100, Robert Jarzmik wrote:
> Hello Arnd, Kevin, Olof,
> 
> Please consider this pxa code for next v3.20 cycle. It was a bit early, but I
> think the upcoming changes around pxa clocks should go for 3.21, and no pending
> patches are in review for v3.20. And yes, I messed up the previous git pull
> email address ...
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-for-3.20
> 
> for you to fetch changes up to a52d209336f8fc7483a8c7f4a8a7d2a8e1692a6c:
> 
>   hx4700: regulator: declare full constraints (2014-12-26 18:05:32 +0100)
> 
> ----------------------------------------------------------------
> arm: pxa: pxa for v3.20
> 
> This update deals mostly with regulator updates for fixing all the
> cases where a default regulator is needed, with non device-tree
> platforms. There's also a kconfig fix for device-tree pxa.
> 
> It should be noticed that all interrupts numbers were shifted by
> 16 (number of legacy interrupts).

Hi Robert,

Branch looks good, I'll merge this into next/fixes-non-critical. One nit below
though:

> ----------------------------------------------------------------
> Dmitry Eremin-Solenikov (3):
>       ARM: pxa: add regulator_has_full_constraints to corgi board file
>       ARM: pxa: add regulator_has_full_constraints to poodle board file
>       ARM: pxa: add regulator_has_full_constraints to spitz board file
> 
> Martin Vajnar (1):
>       hx4700: regulator: declare full constraints

Please use consistent patch subjects in the future. We've ended up using ARM:
<platform>: <foo> across all platforms these days.

I'm not going to ask you to respin just for this, but please remember to fix
future patches when you apply them if they're not already correct.


-Olof
