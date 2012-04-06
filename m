From: gfm@funxed.com (George McBay)
Date: Fri, 6 Apr 2012 00:55:26 -0700
Subject: question about i.mx21ads support
In-Reply-To: <CAOMZO5BWiQoRL3HJy7wgWUjA=FtnJJ9vqt5oau-0n6_SJT_AFQ@mail.gmail.com>
References: <CAEqTKjUyiA_fCfboifSXXj-h_B6rGQpAM9nGnen=0mKi-w=J9w@mail.gmail.com>
 <CAOMZO5BWiQoRL3HJy7wgWUjA=FtnJJ9vqt5oau-0n6_SJT_AFQ@mail.gmail.com>
Message-ID: <CAEqTKjUVrm894Bw62hLNRjfEr2eNVY9aTa1bUM-R3wr1KTRXBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Fabio, this helped point me in the right direction.

This patch applied to 3.2.14 and with a couple of other config changes
in the same area (had to enable support for 2-chip flash interleave,
disable Intel/Sharp and enable ADM/Fujitsu/Spansion flash chips) got
that kernel booting past the Oops I was hitting before.

Unfortunately these changes applied to 3.3 series kernels don't help
with the no-output kernel hang I am seeing with those versions on my
imx21ads board, but this gives me a solid starting point for trying to
find the change that is making the 3.3 kernels hang on this hardware.


On Thu, Apr 5, 2012 at 12:52 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Apr 5, 2012 at 2:30 PM, George McBay <gfm@funxed.com> wrote:
>> I'm attempting to revive an old i.mx21ads board (Freescale dev board,
>> M9328MX21ADS Rev E) with a newish Linux kernel but haven't had yet had
>> luck getting a build after version 3.1.10 to boot successfully. ?Given
>> the age of this platform, it seems entirely plausible that nobody is
>> actually runtime testing against this board, though I suppose it may
>> also come down to something specific in my board revision.
>
> Please try 3.3 kernel instead.
>
> You are probably missing this patch:
> http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=commitdiff;h=1a96571db0a80dbbb935dee26589dd528da0ed06;hp=039d7ba4bcfb1e0040be6f7812a410e6744ce69e
>
> I do not have access to a mx21ads, but Jaccon on Cc has submitted some
> mx21ads related patches recently.
>
> Regards,
>
> Fabio Estevam
