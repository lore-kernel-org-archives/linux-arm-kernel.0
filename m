From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Apr 2017 15:59:01 +0100
Subject: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
In-Reply-To: <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com>
 <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
Message-ID: <20170421145901.3wcft3ou7wwywuiu@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 04:27:14PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
> > stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35 errors, 212 warnings (v3.18.49)

> > 2 arch/mips/mm/fault.c:321:1: error: the frame size of 1104 bytes is larger
> > than 1024 bytes [-Werror=frame-larger-than=]

> This is a result of a newer compiler version, combined with the -Werror
> flag that is applied to arch/mips/, and two of the mips defconfigs overriding
> CONFIG_FRAME_WARN to 1024 on a 64-bit architecture (probably by
> accident).

I'm wondering how good an idea it is to leave -Werror on in stable
kernels given that they're very likely to get used with newer compilers
at some point.  But then I've never been a fan of -Werror in the first
place.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170421/2fa696a6/attachment.sig>
