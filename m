From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 17:15:02 +0200
Subject: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <53BFFEAD.7000405@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
 <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
 <20140711145735.GB6523@ulmo> <53BFFEAD.7000405@nvidia.com>
Message-ID: <20140711151501.GA25810@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 06:11:41PM +0300, Tuomas Tynkkynen wrote:
> On 11/07/14 17:57, Thierry Reding wrote:
> 
> >>I don't think that's going to work? The voltage scaling is handled in hw.
> >
> >Do we have to handle it in hardware or can we opt to do it in software,
> >too?
> >
> 
> With the PLLX, voltage scaling is done entirely in SW. With the DFLL,
> it's possible to stay in open-loop mode and do it in SW, but there's
> not much point in that.

It's kind of ugly how we need to pass the address of the PMU and the
offset of the voltage control register to the DFLL which will then
initiate I2C transactions itself. I'm wondering if that plays well with
the I2C traffic originating from within the kernel.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/c9ef5c4d/attachment-0001.sig>
