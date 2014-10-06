From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 6 Oct 2014 10:24:57 +0300
Subject: [PATCH v5 3/4] ARM: tegra: Add thermal trip points for Jetson TK1
In-Reply-To: <20141003195723.GA6074@amd>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
 <1408616242-21009-4-git-send-email-mperttunen@nvidia.com>
 <20140924183204.GE27076@developer> <20141003195723.GA6074@amd>
Message-ID: <20141006072457.GM9139@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 09:57:24PM +0200, Pavel Machek wrote:
> On Wed 2014-09-24 14:32:06, Eduardo Valentin wrote:
> > Hello Mikko,
> > 
> > On Thu, Aug 21, 2014 at 01:17:21PM +0300, Mikko Perttunen wrote:
> > > This adds critical trip points to the Jetson TK1 device tree.
> > > The device will do a controlled shutdown when either the CPU, GPU
> > > or MEM thermal zone reaches 101 degrees Celsius.
> 
> > > +			trips {
> > > +				trip at 0 {
> > > +					temperature = <101000>;
> > > +					hysteresis = <0>;
> > > +					type = "critical";
> > > +				};
> 
> Would it be still time to switch to some more reasonable unit, like
> degrees celsius? milicelsius is a bit of overkill.. ACPI uses
> deciCelsius, but .. celsius should be enough.
> 

We should be using deciKelvin then.

Cheers,

Peter.
