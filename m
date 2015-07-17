From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jul 2015 10:45:49 +0100
Subject: [PATCH] arm64: remove dead code
In-Reply-To: <CAKv+Gu8f7eEYx183qp5RBHns6sNwYEVCZsw=fKFovTe8FSeBVg@mail.gmail.com>
References: <1437069533-22103-1-git-send-email-msalter@redhat.com>
 <CAKv+Gu_TWN6wGxe4VuuoEzSELbOcqGPtWL_SM4-dFkjai8eLtQ@mail.gmail.com>
 <CAKv+Gu8f7eEYx183qp5RBHns6sNwYEVCZsw=fKFovTe8FSeBVg@mail.gmail.com>
Message-ID: <20150717094549.GF18994@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 07:50:30AM +0100, Ard Biesheuvel wrote:
> (use Geoff's correct email address)
> 
> On 17 July 2015 at 08:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > (adding Geoff and Takahiro)
> >
> > On 16 July 2015 at 19:58, Mark Salter <msalter@redhat.com> wrote:
> >> Commit 68234df4ea79 ("arm64: kill flush_cache_all()") removed
> >> soft_reset() from the kernel. This was the only caller of
> >> setup_mm_for_reboot(), so remove that also.
> >>
> >
> > I am wondering if setup_mm_for_reboot() is being used in the kexec
> > patches. Perhaps we should check that before removing it.

Well, given that I can't see any kexec patches on the radar for 4.3, I'm
happy to merge this clean-up and Geoff can reintroduce the function in
his series if he needs it.

Will
