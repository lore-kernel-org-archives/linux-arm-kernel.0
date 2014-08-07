From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Aug 2014 13:33:34 +0200
Subject: GSoC 2014 #2 status report - Improving Allwinner SoC support
In-Reply-To: <53DFFA5B.1040006@elopez.com.ar>
References: <53BE0B4F.1090001@elopez.com.ar> <53CAC9ED.9080302@elopez.com.ar>
 <53DFFA5B.1040006@elopez.com.ar>
Message-ID: <20140807113334.GC15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Mon, Aug 04, 2014 at 06:25:47PM -0300, Emilio L?pez wrote:
> Hi everyone,
> 
> Here's a status update on my GSoC project for these last two weeks;
> you can find the two previous updates on the list archives[0][1]
> 
> First of all, I have started to prepare for university exams, so
> that has taken some of the time I was using to work on the project.
> I have not stopped working on this though - you will still see
> progress and receive some more of these emails :)
> 
> On the sound side, we now have normal volume 24 bit audio after
> Chen-Yu noticed it was an alignment problem and that we could get
> around it by using S32LE with 24 significant bits. I have also been
> working on rewriting the driver to use DAPM, and I can now manage
> several parts of the codec with it already. If no further obstacles
> show up, I expect to get it completed soon and in shape for a
> initial submission before the end of GSoC.

When I was working on this, this script from Arnaud Patard helped me a
lot to debug the DAPM states:
http://code.bulix.org/ps99ew-86717

> During this period I also sent some patches for the clock support we
> need for the codec and other audio blocks. I firstly did a RFC[2],
> as the PLL2 is different on the A10 revision A, and we'd need some
> sort of quirk handling for that. After settling for a DT-based
> handling, I sent a refreshed series implementing it[3], which is
> currently under review. This quirk handling is also going to be
> needed for the codec driver, as there's a couple of quirks there as
> well.
> 
> I've also sent an updated version[4] of the DMA engine driver
> addressing the comments I got on v2 and including the performance
> and cyclic improvements I mentioned on the previous report - they
> say third time's the charm, so hopefully I can get a review from the
> DMA maintainers this round :)
> 
> You can expect the next status report in about a week's time. There
> are two GSoC weeks remaining until the hard deadline, so that leaves
> time for another weekly report and a wrap-up one.

Thanks a lot for this report, I'm eagerly waiting for the followups :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/d5f53811/attachment.sig>
