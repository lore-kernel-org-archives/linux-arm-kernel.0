From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 14:34:25 +0800
Subject: [PATCH V5 9/9] ARM: dts: tegra: add the PM configurations of PMC
In-Reply-To: <20130403055935.GB6764@avionic-0098.mockup.avionic-design.de>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
 <1364901613-25080-10-git-send-email-josephl@nvidia.com>
 <515B38F7.5050606@wwwdotorg.org>
 <20130403055935.GB6764@avionic-0098.mockup.avionic-design.de>
Message-ID: <1364970865.16957.21.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-03 at 13:59 +0800, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Apr 02, 2013 at 02:00:55PM -0600, Stephen Warren wrote:
> > On 04/02/2013 05:20 AM, Joseph Lo wrote:
> > > Adding the PM configuration of PMC when the platform support suspend
> > > function.
> > 
> > For this patch, some more boards could be supported, but I think we'll
> > have to rely on other people (Lucas, Thierry) to send patches for them,
> > since they know the details of the board. It's fine to leave suspend
> > disabled on those boards until later.
> 
> I'm not sure what would be the best way to get the Tamonten devices out
> of suspend again. For Plutux and TEC we have a power button that could
> possibly be reused. There's a WAKEUP pin on the Tamonten connector which
> goes to GPIO PV2, but the mechanism to trigger it is carrier-board
> dependent.
> 
> For the Medcom-Wide we don't have a power button, but it could possibly
> use the WAKEUP pin if that's connected. It seems like in all designs it
> goes to the CPLD, but I need to check with engineering if there's a way
> to manipulate it.
> 
> So yes, I think for now we can leave suspend disabled on Tamonten and I
> can send patches to enable it once I've clarified with engineering.
> 
Hi Thierry,

I just recall I still need at least "nvidia,cpu-pwr-good-time" and
"nvidia,cpu-pwr-off-time" two properties to make CPU idle power-down
mode (same with LP2) work normally after this series.

So can you provide me that or point me out where is your downstream
kernel source? There data would be come from DT after this series.

Thanks,
Joseph
