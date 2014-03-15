From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 15 Mar 2014 13:07:49 +0000
Subject: [PATCH v5 09/11] arm: add support for reserved memory defined by
 device tree
In-Reply-To: <7h8usdlqbn.fsf@paris.lan>
References: <1392985527-6260-1-git-send-email-m.szyprowski@samsung.com> <
 1392985527-6260-10-git-send-email-m.szyprowski@samsung.com> <
 CAGa+x856+YyJ-vyfGoFAKmsqwKD+=Wh0-TT_mAaPStOXjd8eSQ@mail.gmail.com> <
 20140313213636.GR18529@joshc.qualcomm.com> <7h8usdlqbn.fsf@paris.lan>
Message-ID: <20140315130749.2A38AC40A1B@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Mar 2014 14:51:56 -0700, Kevin Hilman <khilman@linaro.org> wrote:
> Josh Cartwright <joshc@codeaurora.org> writes:
> 
> > On Thu, Mar 13, 2014 at 01:46:50PM -0700, Kevin Hilman wrote:
> >> On Fri, Feb 21, 2014 at 4:25 AM, Marek Szyprowski
> >> <m.szyprowski@samsung.com> wrote:
> >> > Enable reserved memory initialization from device tree.
> >> >
> >> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> 
> >> This patch has hit -next and several legacy (non-DT) boot failures
> >> were detected and bisected down to this patch.  A quick scan looks
> >> like there needs to be some sanity checking whether a DT is even
> >> present.
> >
> > Hmm.  Yes, the code unconditionally calls of_flat_dt_scan(), which will
> > gladly touch initial_boot_params, even though it may be uninitialized.
> > The below patch should allow these boards to boot...
> >
> > However, I'm wondering if there is a good reason why we don't parse the
> > /reserved-memory nodes at the right after we parse the /memory nodes as
> > part of early_init_dt_scan()...
> >
> > Thanks,
> >   Josh
> >
> > --8<--
> > Subject: [PATCH] drivers: of: only scan for reserved mem when fdt present
> >
> > Reported-by: Kevin Hilman <khilman@linaro.org>
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> 
> This gets legacy boot working again.  Thanks.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

Applied and confirmed on non-DT qemu boot. Thanks. It will be pushed out
shortly.

g.
