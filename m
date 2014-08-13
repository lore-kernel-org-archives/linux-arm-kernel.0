From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 13 Aug 2014 11:53:59 -0700
Subject: [PATCH] ARM: Explain workaround for faulty ISAR0 register on B15
In-Reply-To: <1407797053-12544-1-git-send-email-gregory.0xf0@gmail.com>
References: <1407797053-12544-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CADtm3G5EN3juZ8=DaPLD_8vYN+-bWFq92=pzghWpahsq=-JiSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 3:44 PM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
> The Brahma-B15 CPU design, like Krait, incorrectly indicates that it
> only supports UDIV and SDIV instructions in Thumb mode when it
> actually supports them in ARM and Thumb mode.  This is apparently
> because it follows the DDI0406B ARM ARM which has two values for the
> divide instruction field, instead of the DDI0406C ARM ARM which has
> three values.

NAK myself here. Brian Norris pointed out that this is incorrect, and
he'll send a follow-up patch to remove the forced hwcaps.  Sorry for
the noise.

Regards,
Gregory
