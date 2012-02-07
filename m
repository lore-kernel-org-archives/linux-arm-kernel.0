From: ccross@android.com (Colin Cross)
Date: Tue, 7 Feb 2012 09:41:46 -0800
Subject: [RFC] ARM: cache-l2x0.c
In-Reply-To: <CAMN7GVp8=iY7_Mcqra2G0dBBHFg_axiNbPfbaqycy4SGHFOV2A@mail.gmail.com>
References: <CAMN7GVp8=iY7_Mcqra2G0dBBHFg_axiNbPfbaqycy4SGHFOV2A@mail.gmail.com>
Message-ID: <CAMbhsRSEk5OZS0QhPpQHpdO9Y+-KmLD-LJL0DVFz74vYjB2u0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2012 at 3:07 AM, Per Fransson <per.fransson.ml@gmail.com> wrote:
> Hi all,
>
> In the android 3.0 kernel the workaround for PL310 errata 727915 is
> applied both to:
>
> * the clean & invalidate by way and
>
> * the clean by way
>
> But the errata only mentions the first of these operations. Does
> anyone know if it's actually applicable to clean by way as well?
>
> Regards,
> Per

I was able to trigger a reproducible kernel hang/watchdog reset inside
l2x0_clean_all on an OMAP 4430 (pl310 r2p0, I believe), until I added
the set-way based workaround for clean.  My patch came from
discussions with Richard Woodruff.
