From: geoff@infradead.org (Geoff Levand)
Date: Fri, 17 Jul 2015 10:42:59 -0700
Subject: [PATCH] arm64: remove dead code
In-Reply-To: <CAKv+Gu8f7eEYx183qp5RBHns6sNwYEVCZsw=fKFovTe8FSeBVg@mail.gmail.com>
References: <1437069533-22103-1-git-send-email-msalter@redhat.com>
 <CAKv+Gu_TWN6wGxe4VuuoEzSELbOcqGPtWL_SM4-dFkjai8eLtQ@mail.gmail.com>
 <CAKv+Gu8f7eEYx183qp5RBHns6sNwYEVCZsw=fKFovTe8FSeBVg@mail.gmail.com>
Message-ID: <1437154979.1657.23.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2015-07-17 at 08:50 +0200, Ard Biesheuvel wrote:
> > On 16 July 2015 at 19:58, Mark Salter <msalter@redhat.com> wrote:
> >> Commit 68234df4ea79 ("arm64: kill flush_cache_all()") removed
> >> soft_reset() from the kernel. This was the only caller of
> >> setup_mm_for_reboot(), so remove that also.
> >
> > I am wondering if setup_mm_for_reboot() is being used in the kexec
> > patches. Perhaps we should check that before removing it.

The whole CPU reset support that kexec was using was removed.

I started on reimplementing a new cpu_reset() routine (in my
master branch at [1]), but I can only work on it when I have
some extra time, and these days that is not very often.

[1] https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git/

-Geoff
