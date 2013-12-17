From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Dec 2013 10:57:00 +0100
Subject: pwm-backlight: 3.13-rc1 regression for old arm machine
In-Reply-To: <87r49c6bea.fsf@free.fr>
References: <87r49c6bea.fsf@free.fr>
Message-ID: <20131217095658.GD13823@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 04:52:45PM +0100, Robert Jarzmik wrote:
> Hi Thierry,

Hi Robert,

Please always Cc the linux-pwm mailing list for PWM related questions.
I've done that now.

> Since recently, and probable since last Linus's merge of PWM tree (Merge tag
> 'pwm/for-3.13-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm), my
> platform has its backlight broken.
> 
> The particularity of my platform:
>  - arch/arm/mach-pxa/mioa701.c
>  - no device tree
>  - no power supply regulator for backlight
>  - backlight controlled by a PWM
>  - kernel message :
> [    1.495480] platform pwm-backlight: Driver pwm-backlight requests probe deferral
> 
> I think other "old" platforms will suffer from this. Do you have a
> recommendation ?

I hadn't anticipated that =(. In fact I had been holding this patch back
for a release cycle because I was waiting for a specific regulator patch
to land which provides a dummy regulator if one wasn't specified. It
seems that that patch only works when booting from DT, though.

The correct way to fix this would be to provide a lookup table with the
dummy regulator in the board file. I've attached a patch (compile-tested
only) that might work.

If it does, please let me know and, if nobody else volunteers, I'll see
if I can come up with a set of patches to fix this for any other boards
that have the same issue.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-pxa-Add-dummy-power-supply-for-backlight-for-Mit.patch
Type: text/x-diff
Size: 1813 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/194fd6ef/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/194fd6ef/attachment-0001.sig>
