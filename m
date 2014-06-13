From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 13 Jun 2014 10:25:14 +0300
Subject: [PATCH 0/3] Use Tegra's microsecond counter for udelay()
In-Reply-To: <539A01B4.3050503@wwwdotorg.org>
References: <1402588713-18766-1-git-send-email-pdeschrijver@nvidia.com>
 <539A01B4.3050503@wwwdotorg.org>
Message-ID: <20140613072514.GL5961@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 09:38:28PM +0200, Stephen Warren wrote:
> On 06/12/2014 09:58 AM, Peter De Schrijver wrote:
> > This patchset introduces support for Tegra's microsecond counter as the
> > udelay() timer. This is useful on Tegra SoCs which do not have an arch timer
> > such as Tegra20 and Tegra30. Using the microsecond counter instead of a delay
> > based loop avoids potential problems during cpu frequency changes.
> > 
> > The set consists of 3 patches:
> > 
> > Patch 1 introduces a new call which is used by the ARM architecture delay
> > timer code to prevent changing the delay timer after calibration is finished
> > and thus can be in use.
> > 
> > Patch 2 adds logic to choose the delay timer with the highest resolution. This
> > allows the same registration code to be used on all Tegra SoCs and yet use the
> > higher resolution arch timer when available (eg on Tegra114 or Tegra124).
> > 
> > Patch 3 adds the actual delay timer code.
> > 
> > Patch set has been verified on ventana (Tegra20), beaver (Tegra30),
> > dalmore (Tegra114) and jetson TK1 (Tegra124).
> 
> Russell, Paul, do patches 1 and 2 look good to you? If so, if you can
> ack them, I'd be happy to queue this series in the Tegra git tree. If
> that doesn't work for you, please let me know who will apply these
> patches. Thanks.
> 
> > Changes since v1:
> > * Address review comments
> 
> That's not a very useful description of the changes, and there's no "V2"
> in the subject...

Yes... something went wrong it seems...
