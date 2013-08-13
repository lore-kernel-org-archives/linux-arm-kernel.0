From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 13 Aug 2013 10:12:59 +0100
Subject: [Qemu-devel] SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <1376383051.2737.20@driftwood>
References: <20130812164548.GE23006@n2100.arm.linux.org.uk>
 <1376383051.2737.20@driftwood>
Message-ID: <CAFEAcA_KJwzefBH0St2vbGd9gaWsVL9jdrGRBJU9wx2-kuo1vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2013 09:37, Rob Landley <rob@landley.net> wrote:
> Peter says he knows somebody who knows somebody who dug some instance of
> this hardware out of some landfill or something.

No, I personally myself had the hardware. Really.

> Me, I want to get something that works on new qemu _and_ last year's
> qemu, and that's what I got.

Note that in general hoping that current mainline kernel will
always work with ancient QEMU is a losing proposition -- it is
always possible that a kernel improvement will trigger a latent
model bug in QEMU. (To pick a random example, some while ago fixes
to how the kernel dealt with BGR and RGB pixel formats on the
versatile board broke QEMU because we weren't modelling it right;
that was just a QEMU bug for which the fix is "get a newer QEMU".)

The back-compat in the PCI code is so that the older kernels (2.6.x)
will continue to work, which is not quite the same thing.

-- PMM
