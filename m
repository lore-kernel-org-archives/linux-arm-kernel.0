From: swetland@google.com (Brian Swetland)
Date: Tue, 28 Jun 2011 04:36:46 -0700
Subject: [RFC 0/8] Introducing a generic AMP/IPC framework
In-Reply-To: <BANLkTiniBEuHKnmhoJEaVELpMefZ=Xk=bA@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<4E04F0B0.4030408@codeaurora.org>
	<BANLkTi=sFtwam29i4TZdi=RO7BoytTTdrw@mail.gmail.com>
	<FFF198FBBF957F4393BA834040FEFFA202EDA3@DFLE35.ent.ti.com>
	<BANLkTiniBEuHKnmhoJEaVELpMefZ=Xk=bA@mail.gmail.com>
Message-ID: <CANqkERATQbXU7ooHkUX+qieEejMAejRRvSRr606e5mF2d_qtbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 4:26 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Jun 28, 2011 at 12:22 AM, Grosen, Mark <mgrosen@ti.com> wrote:
>> 2. We added a special section (resource table) that is interpreted as part
>> of the loading process. The tool that generates our simple format just
>> recognizes a named section (".resource_table"), so perhaps that could be
>> done with the PIL ELF loader.
>
> I hope that DT will completely replace that "resource table" section
> eventually. We still need to try it out (as soon as DT materializes on
> ARM/pandaboard) and see how it all fits together, but in general it
> looks like DT could provide all the necessary static resource
> configuration, and then we just need to expose it to the remote
> processor.

I'm not sure I see the benefit to pulling the resource information out
of the firmware image.  The resource information is a description of
what resources the firmware requires to work properly (it needs
certain amounts of working memory, timers, peripheral interfaces like
i2c to control camera hw, etc), which will be specific to a given
firmware build.  Pulling that information out into another place adds
new ways for things to break as the firmware and its resource
requirements are now separate and could get out of sync, etc.

Brian
