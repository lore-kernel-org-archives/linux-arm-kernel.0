From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Oct 2015 13:38:15 -0700
Subject: [PATCH/RESEND] ARM: Remove __ref on hotplug cpu die path
In-Reply-To: <20151019202301.GA453@leverpostej>
References: <1445285133-11977-1-git-send-email-sboyd@codeaurora.org>
 <20151019202301.GA453@leverpostej>
Message-ID: <20151019203815.GD22043@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Rutland <mark.rutland@arm.com> [151019 13:27]:
> On Mon, Oct 19, 2015 at 01:05:33PM -0700, Stephen Boyd wrote:
> > Now that __cpuinit has been removed, the __ref markings on these
> > functions are useless. Remove them. This also reduces the size of
> > the multi_v7_defconfig image:
> > 
> > $ size before after
> >    text    data     bss     dec     hex filename
> >    12683578        1470996  348904 14503478         dd4e36 before
> >    12683274        1470996  348904 14503174         dd4d06 after
> > 
> > presumably because now we don't have to jump to code in the
> > .ref.text section and/or the noinline marking is removed.
> 
> FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

And if you need even more acks:

Acked-by: Tony Lindgren <tony@atomide.com>
