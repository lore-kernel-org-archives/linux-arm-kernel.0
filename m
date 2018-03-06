From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Tue, 6 Mar 2018 08:37:57 -0700
Subject: [Freedreno] [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
In-Reply-To: <20180306042656.GJ23018@vireshk-i7>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-3-jcrouse@codeaurora.org>
 <20180305044221.GC23018@vireshk-i7>
 <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
 <20180306042656.GJ23018@vireshk-i7>
Message-ID: <20180306153757.GD15200@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 09:56:56AM +0530, Viresh Kumar wrote:
> On 05-03-18, 08:28, Jordan Crouse wrote:
> > I'm glad you brought this up - I was trying to find a place in the documentation
> > to put it, but since target specific nodes would be a new trick for OPP I didn't
> > quite know how to go about doing it. Do we just list them as Optional: or
> > should we add a target specific section to the documentation and list them out
> > there instead?
> 
> Something like this and you need to have your own compatible string as
> well:
> 
> Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
> 
> But first, what's the purpose of this field? Just to check if it can
> be handled by current bindings.

I'll try to explain but I might need Stephen or some of the other folks to jump
in and save me.

On sdm845 there are shared power resources controlled by the RPMh which is
programed by a series of commands from the regulator driver; but in the case
of the GPU the votes are passed to the GMU (graphics management unit) which
communicates with the RPMh on behalf of the GPU.

In order to construct the RPMh vote we need first need a voltage level that we
can look up in a database. qcom,arc-level is the voltage level associated with
a specific OPP.

I had previously been abusing this with opp-microvolt but that was wrong for
obvious reasons and then Stephen pointed out that this would be a better way.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
