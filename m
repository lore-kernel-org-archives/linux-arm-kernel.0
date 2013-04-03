From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 3 Apr 2013 07:59:35 +0200
Subject: [PATCH V5 9/9] ARM: dts: tegra: add the PM configurations of PMC
In-Reply-To: <515B38F7.5050606@wwwdotorg.org>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
 <1364901613-25080-10-git-send-email-josephl@nvidia.com>
 <515B38F7.5050606@wwwdotorg.org>
Message-ID: <20130403055935.GB6764@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 02:00:55PM -0600, Stephen Warren wrote:
> On 04/02/2013 05:20 AM, Joseph Lo wrote:
> > Adding the PM configuration of PMC when the platform support suspend
> > function.
> 
> For this patch, some more boards could be supported, but I think we'll
> have to rely on other people (Lucas, Thierry) to send patches for them,
> since they know the details of the board. It's fine to leave suspend
> disabled on those boards until later.

I'm not sure what would be the best way to get the Tamonten devices out
of suspend again. For Plutux and TEC we have a power button that could
possibly be reused. There's a WAKEUP pin on the Tamonten connector which
goes to GPIO PV2, but the mechanism to trigger it is carrier-board
dependent.

For the Medcom-Wide we don't have a power button, but it could possibly
use the WAKEUP pin if that's connected. It seems like in all designs it
goes to the CPLD, but I need to check with engineering if there's a way
to manipulate it.

So yes, I think for now we can leave suspend disabled on Tamonten and I
can send patches to enable it once I've clarified with engineering.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130403/573faedf/attachment.sig>
