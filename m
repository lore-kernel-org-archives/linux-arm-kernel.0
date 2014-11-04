From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Nov 2014 10:40:18 +0100
Subject: [PATCH v1 1/2] dtb: xgene: fix: Disable 10GbE and SGMII based
 1GbE by default
In-Reply-To: <CAKh23FkVrPdCuR6dn1S4RvW14_f4Xq8MWaChUh9DyVp44kVtSg@mail.gmail.com>
References: <1414630580-24640-1-git-send-email-isubramanian@apm.com>
 <1991367.DGHysZpQVP@wuerfel>
 <CAKh23FkVrPdCuR6dn1S4RvW14_f4Xq8MWaChUh9DyVp44kVtSg@mail.gmail.com>
Message-ID: <2461768.hHqNmTQE9x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 November 2014 11:45:44 Iyappan Subramanian wrote:
> 
> On Thu, Oct 30, 2014 at 3:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 29 October 2014 17:56:19 Iyappan Subramanian wrote:
> >> @@ -621,7 +621,7 @@
> >>                         };
> >>                 };
> >>
> >> -               sgenet0: ethernet at 1f210000 {
> >> +               sgenet0: sgenet at 1f210000 {
> >>                         compatible = "apm,xgene-enet";
> >>                         status = "disabled";
> >>                         reg = <0x0 0x1f210000 0x0 0x10000>,
> >>
> >
> > This looks like you accidentally reverted a bug fix made earlier.
> > Network devices should always have the name 'ethernet at ...'.
> 
> Thanks for the review.  Since our firmware was patching the dtb, based
> on the node-name, we thought by changing node-name, we can avoid the
> patching and maintain backward compatibility.
> 
> Now we know that network devices should have 'ethernet at ...', we will
> handle the backward compatibility in a different way and will post the
> patch v2 shortly.

It's not important enough to break backwards compatibility over this.
If you can't find a better way to handle compatibility with the old
firmware, just add a comment explaining the node name.

	Arnd
