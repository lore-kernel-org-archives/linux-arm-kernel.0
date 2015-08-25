From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Aug 2015 11:02:54 +0100
Subject: [PATCH 0/2] arm64: ignore memory outside of the linear range
In-Reply-To: <CAKv+Gu-d77ab78WfT8r9YovrNXwFtpq4K9uKmSq5E1jOmRitYw@mail.gmail.com>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <CY1PR0301MB0748FC71E6866C8AFACAAFF687780@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu-OQ4VyCqe=mEDOrrfAtAWTfRtAiqXMGSVjJxOH6xi4Ow@mail.gmail.com>
 <20150824092256.GA11262@arm.com>
 <CY1PR0301MB0748EAE8103DDF771A37785787620@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150824140828.GB20147@arm.com>
 <CY1PR0301MB07481C5861695902A75CD23D87620@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu-d77ab78WfT8r9YovrNXwFtpq4K9uKmSq5E1jOmRitYw@mail.gmail.com>
Message-ID: <20150825100254.GB21300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 10:45:01AM +0100, Ard Biesheuvel wrote:
> On 25 August 2015 at 00:34, Stuart Yoder <stuart.yoder@freescale.com> wrote:
> >> On Mon, Aug 24, 2015 at 02:58:26PM +0100, Stuart Yoder wrote:
> >> > Are we sending to stable as well?
> >>
> >> I've already pushed the patch out without a Cc stable (it's not a
> >> regression afaict), so if you want it backported then you'll need to send
> >> it to stable separately.
> >
> > Ok, was asking because of Catalin's previous comment:
> >
> >  > Even though it is not a regression, I think it is a bug fix and it's
> >  > worth cc'ing stable (though we could push it after 4.3-rc1).
> >
> 
> Indeed. Catalin also mentioned that you and he discussed a minimal fix
> with a cc to stable, only the fix itself was flawed. So let's not make
> this Stuart's problem, considering that this issue breaks all arm64
> systems with 32+ GB of RAM if they follow ARM's own recommendation
> regarding the physical layout of memory.
> 
> > Ard, are you going to send to stable?
> >
> 
> We'll have to wait until the merge window closes, of course, but yes,
> we should propose it.
> 
> @Will: what do you think? It would be nice to have you on record with
> an opinion rather than leaving it up to Stuart.

This isn't something that has *ever* worked with the arm64 kernel,
right? In which case, it's not a regression, it's more like adding
support for some systems that we've not supported before. Now, given the
nature of the patch, I'm not against stable, but by the time Stuart
pointed that out, I'd already pushed the patch and I don't want to
rebase our 4.3 queue at this stage.

The best bet is to send this to stable once it's in mainline (i.e. -rc1)
and I think it makes sense for Stuart to do that, since he is the one
most interested in having that happen.

Will
