From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 4 Feb 2015 09:53:28 -0600
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150204104832.GF8656@n2100.arm.linux.org.uk>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <8901765.mLfPOCUyAN@vostro.rjw.lan>
 <20150204104832.GF8656@n2100.arm.linux.org.uk>
Message-ID: <CAErSpo71fVU5mJgXnxMwiE_TUrNyfSYHo5RDF-=u2BK5grDYAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 4:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Moreover, __weak is positively harmful when you consider it adds bloat
> and dead code - the overriden __weak function is left behind in the
> resulting final image.

Huh, I didn't realize that.  Is that a linker bug, or is there some
reason the weak function has to be in the final image?  I tried a
trivial test on x86 with gcc-4.8.2/ld-2.24, and I think the weak
function text was omitted, but a string constant used only by the weak
function was included.

Bjorn
