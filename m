From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Nov 2014 20:25:22 +0100
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <545D3B31.3030309@gmail.com>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
 <2747100.M77UGx4AmB@wuerfel> <545D3B31.3030309@gmail.com>
Message-ID: <1630864.S0zQWJED9T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 November 2014 13:35:45 Frank Rowand wrote:
> On 11/7/2014 1:47 AM, Arnd Bergmann wrote:
> > On Thursday 06 November 2014 22:42:47 Frank Rowand wrote:
> >> This same change is also needed in:
> >>
> >>   qcom-ipq8064.dtsi
> >>   qcom-msm8960.dtsi
> >>   qcom-apq8084.dtsi
> >>   qcom-apq8064.dtsi
> >>   qcom-msm8660.dtsi
> >>
> >> but I did not want to just blindly apply those changes without testing.
> >>
> > 
> > Is there only one uart on each of these?
> > 
> > If not, it would be better to put the aliases in the board specific file,
> > pointing to whichever ports are in use, in the order that makes sense
> > for that board.
> 
> Good point, thanks for bringing it up.
> 
> Your comment made me verify that the board dts files can override the
> aliases from the included .dtsi.  So not a problem to have a default
> set of aliases in the .dtsi files.

I would think it's better to keep them in the per-board file out of
principle though.
	
	Arnd
