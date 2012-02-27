From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 27 Feb 2012 21:05:08 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <1330360043.8557.302.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1330360043.8557.302.camel@zakaz.uk.xensource.com>
Message-ID: <CAFEAcA8PzT9mfnEz60CYvwQWX1OEvejrZvkpuPL2LpTPosp8cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2012 16:27, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> R12 is not accessible from the 16 bit "T1" Thumb encoding of mov
> immediate (which can only target r0..r7).
>
> Since we support only ARMv7+ there are "T2" and "T3" encodings available
> which do allow direct mov of an immediate into R12, but are 32 bit Thumb
> instructions.
>
> Should we use r7 instead to maximise instruction density for Thumb code?

r7 is (used by gcc as) the Thumb frame pointer; I don't know if this
makes it worth avoiding in this context.

-- PMM
