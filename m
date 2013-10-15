From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Oct 2013 11:29:24 +0300
Subject: [PATCH 03/10] clk: tegra: Staticize local variables in clk-pll.c
In-Reply-To: <525C1D6E.5070802@wwwdotorg.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
 <1381231068-6053-3-git-send-email-sachin.kamat@linaro.org>
 <52542E34.6020806@wwwdotorg.org>
 <20131010111328.GS4233@tbergstrom-lnx.Nvidia.com>
 <5256D0CA.9010906@wwwdotorg.org>
 <20131014081533.GZ4233@tbergstrom-lnx.Nvidia.com>
 <525C1D6E.5070802@wwwdotorg.org>
Message-ID: <20131015082924.GC19540@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 06:35:58PM +0200, Stephen Warren wrote:
> On 10/14/2013 02:15 AM, Peter De Schrijver wrote:
> > On Thu, Oct 10, 2013 at 06:07:38PM +0200, Stephen Warren wrote:
> >> On 10/10/2013 05:13 AM, Peter De Schrijver wrote:
> >>> On Tue, Oct 08, 2013 at 06:09:24PM +0200, Stephen Warren wrote:
> >>>> On 10/08/2013 05:17 AM, Sachin Kamat wrote:
> >>>>> Local variables used only in this file are made static.
> >>>>
> >>>
> >>> Conceptually they are still exported. So I think it's counterintuitive to
> >>> declare them static. Unless you expect namespace problems, I would rather
> >>> leave it as is.
> >>
> >> I forget exactly which symbols this patch changed, but presumably
> >> they're only exported via pointers rather than by symbol name, and isn't
> >> that exactly what static is for?
> > 
> > They are indeed exported using a pointer. depends on how you look at it I
> > guess, but I see static as 'local to this file only' which isn't really
> > true if you hand out pointers to others.
> 
> Yes, static specifically means "the symbol name is local to this file".
> It says nothing about the data behind the symbol name.

I would still prefer the symbol visibility to have some relation with how
the data is used.
