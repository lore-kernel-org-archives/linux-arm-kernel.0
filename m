From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 25 Sep 2014 12:05:28 +0100
Subject: [PATCH RESEND] arm: don't break misaligned NEON load/store
In-Reply-To: <15fc86b0d2b4984377d7116113b0f2f9498bd088.1411392970.git.robin.murphy@arm.com>
References: <15fc86b0d2b4984377d7116113b0f2f9498bd088.1411392970.git.robin.murphy@arm.com>
Message-ID: <5423F6F8.2060902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/14 14:48, Robin Murphy wrote:
> The alignment fixup incorrectly decodes faulting ARM VLDn/VSTn
> instructions (where the optional alignment hint is given but incorrect)
> as LDR/STR, leading to register corruption. Detect these and correctly
> treat them as unhandled, so that userspace gets the fault it expects.
>
> Reported-by: Simon Hosie <simon.hosie@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Cc: <stable@vger.kernel.org>
> ---
>
> Hi all,
>
> This was met with a resounding silence a while back[1], but the bug is
> still causing annoyance - apparently Clang intrinsics can be a little
> over-eager with alignment hints. Regardless of whose fault that is,
> the kernel shouldn't be silently mangling registers unexpectedly.
>
> Any objections to me dropping this into the patch system?
>

Since nobody's voiced any complaints, I've submitted this as 8165/1.

Robin.
